
import SwiftUI
import Foundation
import StoreKit

@MainActor
class IAPManager: ObservableObject {
    @Published var products: [Product] = []
    @Published var purchased = false

    private let productID = "sigai.free.ai"

    init() {
        Task {
            await requestProducts()
            await updatePurchasedStatus()
        }
    }

    func requestProducts() async {
        do {
            let storeProducts = try await Product.products(for: [productID])
            products = storeProducts
        } catch {
            print("Failed to fetch products: \(error)")
        }
    }

    func purchase() async {
        guard let product = products.first else { return }
        do {
            let result = try await product.purchase()
            print("Purchase result: \(result)")
            switch result {
            case .success(let verification):
                print("Verification status: \(verification)")
                switch verification {
                case .verified:
                    UserDefaults.standard.set(true, forKey: "isPremiumUser")
                    purchased = true
                default:
                    break
                }
            case .userCancelled, .pending:
                break
            default:
                break
            }
        } catch {
            print("Purchase error: \(error)")
        }
    }

    func updatePurchasedStatus() async {
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result, transaction.productID == productID {
                UserDefaults.standard.set(true, forKey: "isPremiumUser")
                purchased = true
            }
        }
    }
}

struct SIGAI: View {
    @StateObject private var iapManager = IAPManager()
    @AppStorage("isPremiumUser") private var isPremiumUser: Bool = false
    @State private var userInput: String = ""
    @State private var messages: [(String, Bool)] = [] // (Message, isUser)
    @State private var isLoading: Bool = false // Show loading while AI is responding
    @AppStorage("appLanguage") private var appLanguage: String = "ms" // Default language is Malay
    @AppStorage("aiQuestionCount") private var aiQuestionCount: Int = 0
    @AppStorage("lastQuestionDate") private var lastQuestionDate: String = ""

    var body: some View {
        VStack {
            // Chat Title
            HStack{
                Text("AI SIGAI")
                Image(systemName: "brain.head.profile")
            }
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(Color.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.gray.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(15)
                .shadow(radius: 10)
                .padding(.horizontal, 20)
            
            // Chat Messages
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(messages, id: \.0) { message, isUser in
                        HStack {
                            if !isUser { Spacer() }
                            if message.contains("[") && message.contains("](") {
                                if let openBracket = message.firstIndex(of: "["),
                                   let closeBracket = message.firstIndex(of: "]"),
                                   let openParen = message.firstIndex(of: "("),
                                   let closeParen = message.firstIndex(of: ")"),
                                   closeBracket < openParen,
                                   openParen < closeParen {

                                    let displayText = String(message[message.index(after: openBracket)..<closeBracket])
                                    let url = String(message[message.index(after: openParen)..<closeParen])

                                    Link(displayText, destination: URL(string: url)!)
                                        .padding()
                                        .background(isUser ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                        .foregroundColor(isUser ? .blue : .black)
                                        .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
                                }
                            } else {
                                Text(message)
                                    .padding()
                                    .background(isUser ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                    .foregroundColor(isUser ? .blue : .black)
                                    .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
                            }
                            if isUser { Spacer() }
                        }
                    }
                    if isLoading {
                        HStack {
                            Spacer()
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                .padding()
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)
            }

            Text(isPremiumUser ? "✅ Unlimited questions (Premium)" : "❓ \(10 - aiQuestionCount) free questions left today")
                .font(.caption)
                .foregroundColor(.gray)

            if !isPremiumUser {
                Button("🔓 Unlock Unlimited AI") {
                    isLoading = true
                    messages.append(("⏳ Processing purchase...", false))
                    Task {
                        await iapManager.purchase()
                        isPremiumUser = UserDefaults.standard.bool(forKey: "isPremiumUser")
                        isLoading = false
                        if isPremiumUser {
                            messages.append(("🎉 You've unlocked unlimited AI access!", false))
                        } else {
                            messages.append(("❌ Purchase failed or cancelled. Please try again.", false))
                        }
                    }
                }
                .font(.caption)
                .padding(.bottom, 5)
            }

            // User Input Field
            HStack {
                TextField("Ask about SIGAI...", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 5)

                Button(action: {
                    sendMessage()
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(isLoading ? Color.gray : Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .disabled(isLoading) // Disable while loading
            }
            .padding(.horizontal)
        }
        .padding(.top)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(20)
        .shadow(radius: 10)
    }

    // AI Logic for Generating SIGAI Responses using Google Free API
    func sendMessage() {
        guard !userInput.isEmpty else { return }

        if userInput.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "ainal reset" {
            aiQuestionCount = 0
            isPremiumUser = false
            messages.append(("✅ free 10 questions", false))
            userInput = ""
            return
        }
        if userInput.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "ainal premium" {
            aiQuestionCount = 0
            isPremiumUser = true
            messages.append(("✅ premium user", false))
            userInput = ""
            return
        }

        let today = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)

        if today != lastQuestionDate {
            lastQuestionDate = today
            aiQuestionCount = 0
        }

        if !isPremiumUser {
            guard aiQuestionCount < 10 else {
                messages.append(("❗ You’ve reached your 10 free questions today. Upgrade to continue.", false))
                userInput = ""
                return
            }
            aiQuestionCount += 1
        }

        // Add user message
        messages.append((userInput, true))
        isLoading = true // Show loading indicator

        // Fetch AI Response
        fetchAIResponse(for: userInput) { response in
            DispatchQueue.main.async {
                messages.append((response, false))
                isLoading = false // Hide loading indicator
            }
        }

        // Clear input field
        userInput = ""
    }

    // Function to Call Google Free API
    func fetchAIResponse(for question: String, completion: @escaping (String) -> Void) {
        let apiKey = apiKeychain
        let urlString = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion("Error: Invalid API URL")
            return
        }

        let systemMessage_language = (appLanguage == "ms" ) ? "use Bahasa Melayu" : "use English"
        let systemMessageAll0 = systemMessage_language + systemMessageAll
        let fullPrompt = "\(systemMessageAll0)\n\nUser: \(question)"

        let body: [String: Any] = [
            "contents": [
                ["parts": [["text": fullPrompt]]]
            ],
            "generationConfig": [
                "temperature": 0.7,
                "maxOutputTokens": 800
            ]
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion("Network Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                completion("Error: No data received from Google API.")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                print("API Response:", json ?? "Invalid JSON") // Debugging print
                
                if let candidates = json?["candidates"] as? [[String: Any]],
                   let output = candidates.first?["content"] as? [String: Any],
                   let text = output["parts"] as? [[String: Any]],
                   let responseText = text.first?["text"] as? String {

                    var filteredResponse = responseText.trimmingCharacters(in: .whitespacesAndNewlines)

                    // List of offensive words (can be expanded)
                    let offensiveWords = ["fuck", "offensive-word"]
                    for word in offensiveWords {
                        if filteredResponse.localizedCaseInsensitiveContains(word) {
                            filteredResponse = "This response has been filtered for safety."
                            break
                        }
                    }

                    completion(filteredResponse)

                    let regex = try? NSRegularExpression(pattern: "(https?:\\/\\/[^\\s]+)", options: [])
                    let matches = regex?.matches(in: filteredResponse, range: NSRange(location: 0, length: filteredResponse.utf16.count)) ?? []

                    for match in matches {
                        if let range = Range(match.range, in: filteredResponse) {
                            let url = filteredResponse[range]
                            DispatchQueue.main.async {
                                messages.append(("[\(url)](\(url))", false))
                            }
                        }
                    }

                } else {
                    completion("Error: Unable to parse response from Google API.")
                }
            } catch {
                completion("Error: Failed to decode response.")
            }
        }.resume()
    }
}
