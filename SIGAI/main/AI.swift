import SwiftUI
import Foundation
import StoreKit

@MainActor
class IAPManager: ObservableObject {
    @Published var products: [Product] = []
    @Published var purchased = false

    enum RestoreStatus {
        case none
        case restoring
        case success
        case failed(String)
        case noPurchases
    }

    @Published var restoreStatus: RestoreStatus = .none

    private let productID = "sigai.free.ai"

    init() {
        Task {
            await requestProducts()
            await updatePurchasedStatus()
            await listenForTransactions()
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
                case .verified(let transaction):
                    UserDefaults.standard.set(true, forKey: "isPremiumUser")
                    purchased = true
                    await transaction.finish()
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

    func listenForTransactions() async {
        for await result in Transaction.updates {
            if case .verified(let transaction) = result, transaction.productID == productID {
                UserDefaults.standard.set(true, forKey: "isPremiumUser")
                purchased = true
                await transaction.finish()
            }
        }
    }

    func restorePurchases() async {
        restoreStatus = .restoring
        do {
            try await AppStore.sync()
            await updatePurchasedStatus()
            if purchased {
                restoreStatus = .success
            } else {
                restoreStatus = .noPurchases
            }
        } catch {
            restoreStatus = .failed(error.localizedDescription)
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

    @State private var showRestoreAlert = false
    @State private var restoreMessage = ""
    @State private var typingIndicator = ""

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
            
            // Chat Messages (with auto-scroll)
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(messages.indices, id: \.self) { index in
                            let message = messages[index]
                            let text = message.0
                            let isUser = message.1
                            HStack {
                                if !isUser { Spacer() }
                                if text.contains("[") && text.contains("](") {
                                    if let openBracket = text.firstIndex(of: "["),
                                       let closeBracket = text.firstIndex(of: "]"),
                                       let openParen = text.firstIndex(of: "("),
                                       let closeParen = text.firstIndex(of: ")"),
                                       closeBracket < openParen,
                                       openParen < closeParen {

                                        let displayText = String(text[text.index(after: openBracket)..<closeBracket])
                                        let url = String(text[text.index(after: openParen)..<closeParen])

                                        Link(displayText, destination: URL(string: url)!)
                                            .padding()
                                            .background(isUser ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                                            .cornerRadius(10)
                                            .foregroundColor(isUser ? .blue : .black)
                                            .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
                                    }
                                } else {
                                    Text(text)
                                        .padding()
                                        .background(isUser ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                        .foregroundColor(isUser ? .blue : .black)
                                        .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
                                }
                                if isUser { Spacer() }
                            }
                            .id(index)
                        }
                        if isLoading {
                            HStack {
                                Text("✍️\(typingIndicator)")
                                    .padding()
                                    .cornerRadius(10)
                                    .foregroundColor(.gray)
                                    .onAppear {
                                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                                            if !isLoading {
                                                timer.invalidate()
                                            } else {
                                                switch typingIndicator {
                                                case "":
                                                    typingIndicator = "."
                                                case ".":
                                                    typingIndicator = ".."
                                                case "..":
                                                    typingIndicator = "..."
                                                case "...":
                                                    typingIndicator = "...."
                                                case "....":
                                                    typingIndicator = "....."
                                                case ".....":
                                                    typingIndicator = "......"
                                                default:
                                                    typingIndicator = ""
                                                }
                                            }
                                        }
                                    }
                                Spacer()
                            }
                            .id(messages.count)
                        }
                    }
                    .padding(.horizontal)
                }
                .onChange(of: messages.count) { _ in
                    withAnimation {
                        proxy.scrollTo(isLoading ? messages.count : max(messages.count - 1, 0), anchor: .bottom)
                    }
                }
            }

            Text(isPremiumUser ? "✅ Unlimited questions (Premium)" : "❓ \(10 - aiQuestionCount) free questions left today")
                .font(.caption)
                .foregroundColor(.gray)

            if !isPremiumUser {
                HStack{
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
                    Button("🔄 Restore Purchases") {
                        isLoading = true
                        messages.append(("⏳ Restoring purchase...", false))
                        Task {
                            await iapManager.restorePurchases()
                            isPremiumUser = UserDefaults.standard.bool(forKey: "isPremiumUser")
                            
                            switch iapManager.restoreStatus {
                            case .success:
                                restoreMessage = "✅ Purchases restored successfully!"
                            case .noPurchases:
                                restoreMessage = "ℹ️ No previous purchases found to restore."
                            case .failed(let error):
                                restoreMessage = "❌ Restore failed: \(error)"
                            default:
                                restoreMessage = ""
                            }

                            showRestoreAlert = true
                            isLoading = false
                            messages.append((restoreMessage, false))
                        }
                    }
                    .font(.caption)
                    .padding(.bottom, 5)
                    //.alert(isPresented: $showRestoreAlert) {
                    //    Alert(title: Text("Restore Purchases"), message: Text(restoreMessage), dismissButton: .default(Text("OK")))
                    //}
                }
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
                var animatedResponse = ""
                isLoading = false // Hide loading indicator after starting typing

                Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
                    if animatedResponse.count < response.count {
                        let index = response.index(response.startIndex, offsetBy: animatedResponse.count)
                        animatedResponse.append(response[index])
                        if messages.indices.contains(messages.count - 1), messages[messages.count - 1].1 == false {
                            messages[messages.count - 1].0 = animatedResponse
                        } else {
                            messages.append((animatedResponse, false))
                        }
                    } else {
                        timer.invalidate()
                    }
                }
            }
        }

        // Clear input field
        userInput = ""
    }

    // Function to Call Google Free API (Optimized Version)
    func fetchAIResponse(for question: String, completion: @escaping (String) -> Void) {
        guard let apiKey = apiKeychain.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion("Error: Invalid API Key")
            return
        }

        let urlString = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=\(apiKey)"

        guard let url = URL(string: urlString) else {
            completion("Error: Invalid API URL")
            return
        }

        let systemLanguage = (appLanguage == "ms") ? "use Bahasa Melayu" : "use English"
        let prompt = "\(systemLanguage)\n\nUser: \(question)"

        let body: [String: Any] = [
            "contents": [
                ["parts": [["text": prompt]]]
            ],
            "generationConfig": [
                "temperature": 0.7,
                "maxOutputTokens": 800
            ]
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion("Network Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                completion("Error: No data received.")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let candidates = json["candidates"] as? [[String: Any]],
                   let output = candidates.first?["content"] as? [String: Any],
                   let parts = output["parts"] as? [[String: Any]],
                   let responseText = parts.first?["text"] as? String {
                    
                    var filteredText = responseText.trimmingCharacters(in: .whitespacesAndNewlines)

                    // Filter bad words
                    let bannedWords = ["fuck", "offensive-word"]
                    if bannedWords.contains(where: { filteredText.localizedCaseInsensitiveContains($0) }) {
                        filteredText = "This response has been filtered for safety."
                    }

                    completion(filteredText)
                    
                } else {
                    completion("Error: Unable to parse AI response.")
                }
            } catch {
                completion("Error: Failed to decode AI response.")
            }
        }

        task.resume()
    }
}
