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
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
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
    @State private var showPurchaseOptions = false
    @State private var purchaseLoadingIndicator = ""
    @State private var isProcessingPurchase = false
    @State private var isRestoringPurchase = false

    var body: some View {
        VStack {
            // Modern, minimalist, kiddy header
            VStack(spacing: 0) {
                HStack(spacing: 10) {
                    Text("AI SIGAI")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(isDarkMode ? Color.yellow : Color(hex: "#FF4D88"))
                        .shadow(color: Color(hex: "#FF4D88").opacity(0.0), radius: 0, x: 0, y: 0)
                    //Image(systemName: "robot")
                        //.font(.title2)
                        //.foregroundColor(Color(hex: "#FF4D88"))
                        //.shadow(color: Color(hex: "#FF4D88").opacity(0.0), radius: 0, x: 0, y: 0)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
                .padding(.bottom, 2)
                // Question status - minimalist
                Text(
                    isPremiumUser
                        ? "Unlimited questions (Premium)"
                        : "\(10 - aiQuestionCount) free questions left today"
                )
                    .font(.caption2.weight(.medium))
                    .foregroundColor(Color(hex: "#FFB6C1"))
                    .padding(.bottom, 12)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: isDarkMode == true ? [
                        Color(red: 50/255, green: 50/255, blue: 100/255), // Dark Blue
                        Color(red: 80/255, green: 80/255, blue: 150/255)  // Slightly lighter Dark Blue
                    ] : [
                        Color(hex: "#FFD6EC"),
                        Color.white
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.10), radius: 6, x: 0, y: 4)
            .padding(.horizontal, 16)
            .padding(.top, 22)
            .onTapGesture {
                withAnimation {
                    showPurchaseOptions.toggle()
                }
            }

            // Unlock/Restore Buttons - vertical, full width, pastel, rounded, shadow
            if showPurchaseOptions && !isPremiumUser {
                VStack(spacing: 8) {
                    Button(action: {
                        isProcessingPurchase = true
                        isLoading = true
                        purchaseLoadingIndicator = ""
                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                            if !isLoading {
                                timer.invalidate()
                            } else {
                                switch purchaseLoadingIndicator {
                                case "": purchaseLoadingIndicator = "."
                                case ".": purchaseLoadingIndicator = ".."
                                case "..": purchaseLoadingIndicator = "..."
                                case "...": purchaseLoadingIndicator = "...."
                                case "....": purchaseLoadingIndicator = "....."
                                case ".....": purchaseLoadingIndicator = "......"
                                default: purchaseLoadingIndicator = ""
                                }
                                
                                if let lastIdx = messages.indices.last, messages[lastIdx].1 == false {
                                    messages[lastIdx].0 = "⏳ Processing\(purchaseLoadingIndicator)"
                                } else {
                                    messages.append(("⏳ Processing\(purchaseLoadingIndicator)", false))
                                }
                            }
                        }
                        Task {
                            await iapManager.purchase()
                            isPremiumUser = UserDefaults.standard.bool(forKey: "isPremiumUser")
                            isLoading = false
                            isProcessingPurchase = false
                            // Animate purchase success/failure message character by character
                            let fullText = isPremiumUser
                                ? "🎉 You've unlocked unlimited AI access!"
                                : "❌ Purchase failed or cancelled. Please try again."
                            var animatedText = ""
                            Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
                                if animatedText.count < fullText.count {
                                    let index = fullText.index(fullText.startIndex, offsetBy: animatedText.count)
                                    animatedText.append(fullText[index])
                                    if let lastIdx = messages.indices.last, messages[lastIdx].1 == false {
                                        messages[lastIdx].0 = animatedText
                                    } else {
                                        messages.append((animatedText, false))
                                    }
                                } else {
                                    timer.invalidate()
                                }
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "lock.open.fill")
                                .font(.system(size: 18, weight: .bold))
                                .frame(width: 22)
                            Text("Unlock Unlimited AI")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundColor(isDarkMode ? .white : .black)
                        }
                        // Foreground color set on Text above
                        .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
                    }
                    .background(isDarkMode ? Color(red: 80/255, green: 80/255, blue: 120/255) : Color(hex: "#B3E5FC"))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    .scaleEffect(showPurchaseOptions ? 1 : 0.5)
                    .animation(.spring(response: 0.4, dampingFraction: 0.6), value: showPurchaseOptions)

                    Button(action: {
                        isRestoringPurchase = true
                        isLoading = true
                        purchaseLoadingIndicator = ""
                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                            if !isLoading {
                                timer.invalidate()
                            } else {
                                switch purchaseLoadingIndicator {
                                case "": purchaseLoadingIndicator = "."
                                case ".": purchaseLoadingIndicator = ".."
                                case "..": purchaseLoadingIndicator = "..."
                                case "...": purchaseLoadingIndicator = "...."
                                case "....": purchaseLoadingIndicator = "....."
                                case ".....": purchaseLoadingIndicator = "......"
                                default: purchaseLoadingIndicator = ""
                                }
                                
                                if let lastIdx = messages.indices.last, messages[lastIdx].1 == false {
                                    messages[lastIdx].0 = "⏳ Restoring\(purchaseLoadingIndicator)"
                                } else {
                                    messages.append(("⏳ Restoring\(purchaseLoadingIndicator)", false))
                                }
                            }
                        }
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
                            isRestoringPurchase = false
                            // Animate restore message character by character
                            let fullText = restoreMessage
                            var animatedText = ""
                            Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
                                if animatedText.count < fullText.count {
                                    let index = fullText.index(fullText.startIndex, offsetBy: animatedText.count)
                                    animatedText.append(fullText[index])
                                    if let lastIdx = messages.indices.last, messages[lastIdx].1 == false {
                                        messages[lastIdx].0 = animatedText
                                    } else {
                                        messages.append((animatedText, false))
                                    }
                                } else {
                                    timer.invalidate()
                                }
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .font(.system(size: 18, weight: .bold))
                                .frame(width: 22)
                            Text("Restore Purchases")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundColor(isDarkMode ? .white : .black)
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
                    }
                  .background(isDarkMode ? Color(red: 60/255, green: 80/255, blue: 60/255) : Color(hex: "#C8E6C9"))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    .scaleEffect(showPurchaseOptions ? 1 : 0.5)
                    .animation(.spring(response: 0.4, dampingFraction: 0.6), value: showPurchaseOptions)
                }
                .padding(.horizontal, 18)
                .padding(.top, 12)
                .padding(.bottom, 6)
            }

            // Chat Messages (with auto-scroll)
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(messages.indices, id: \.self) { index in
                            let message = messages[index]
                            let text = message.0
                            let isUser = message.1
                            HStack {
                                if !isUser { Spacer() }
                                // Use soft pastel bubble for all AI messages (including ❗️, ✅, etc)
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
                                            .background(
                                                isUser
                                                ? (isDarkMode ? Color(red: 200/255, green: 255/255, blue: 240/255) : Color(hex: "#E6F0FF"))
                                                : (isDarkMode ? Color(red: 50/255, green: 50/255, blue: 100/255) : Color(hex: "#FFE6E6"))
                                            )                                            .cornerRadius(14)
                                            .foregroundColor(.gray)
                                            .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
                                            .scaleEffect(isUser ? 1.05 : 1.02)
                                            .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.5), value: messages.count)
                                    }
                                }
                                // Detect plain URLs and make them clickable (improved splitting version)
                                else if let urlRange = text.range(of: #"https?:\/\/\S+"#, options: .regularExpression) {
                                    let beforeLink = String(text[..<urlRange.lowerBound])
                                    let urlString = String(text[urlRange])
                                    let afterLink = String(text[urlRange.upperBound...])

                                    VStack(alignment: isUser ? .trailing : .leading, spacing: 5) {
                                        if !beforeLink.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                            Text(beforeLink)
                                                .foregroundColor(.gray)
                                        }
                                        if let url = URL(string: urlString) {
                                            Link(urlString, destination: url)
                                                .foregroundColor(.blue)
                                        }
                                        if !afterLink.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                            Text(afterLink)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding()
                                    
                                    .background(
                                        isUser
                                        ? (isDarkMode ? Color(red: 200/255, green: 255/255, blue: 240/255) : Color(hex: "#E6F0FF"))
                                        : (isDarkMode ? Color(red: 50/255, green: 50/255, blue: 100/255) : Color(hex: "#FFE6E6"))
                                    )
                                    .cornerRadius(14)
                                    .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
                                }
                                else {
                                    Text(text)
                                        .padding()
                                        .background(
                                            isUser
                                            ? (isDarkMode ? Color(red: 200/255, green: 255/255, blue: 240/255) : Color(hex: "#E6F0FF"))
                                            : (isDarkMode ? Color(red: 50/255, green: 50/255, blue: 100/255) : Color(hex: "#FFE6E6"))
                                        )
                                        .cornerRadius(14)
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
                                        .scaleEffect(isUser ? 1.05 : 1.02)
                                        .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.5), value: messages.count)
                                }
                                if isUser { Spacer() }
                            }
                            .id(index)
                        }
                        if isLoading && !isProcessingPurchase && !isRestoringPurchase {
                            HStack {
                                Text("☁️ Thinking\(typingIndicator)")
                                    .padding()
                                    .background(isDarkMode ? Color(red: 50/255, green: 50/255, blue: 100/255) : Color(hex: "#FFE6E6"))
                                    .cornerRadius(14)
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

            // User Input Field
            HStack(alignment: .center) {
                TextField("Ask about SIGAI...", text: $userInput)
                    .padding(.vertical, 13)
                    .padding(.horizontal, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.8))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    )
                    .foregroundColor(.black) // Add this line
                    .font(.body)
                    .frame(minHeight: 44, maxHeight: 48)

                Button(action: {
                    if isLoading {
                        // User wants to stop AI response
                        isLoading = false
                    } else {
                        sendMessage()
                    }
                }) {
                    Image(systemName: isLoading ? "stop.fill" : "paperplane.fill")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(isLoading ? Color.gray : (isDarkMode ? Color(red: 50/255, green: 50/255, blue: 100/255) : Color.pink))
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                }
                .disabled(isLoading && messages.last?.1 == true) // Allow stop button, but block sending new
            }
            .frame(minHeight: 56)
            .padding(.horizontal)
            .padding(.top, 10)
            //.padding(.bottom, 90)
        }
        .padding(.top, 0)
        .padding(.bottom, 0)
        .background(
            LinearGradient(
                gradient: Gradient(colors: isDarkMode == true ? [
                    Color.black,
                    Color.white
                ] : [
                    Color(hex: "#FFEFF7"),
                    Color.white
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }

    // AI Logic for Generating SIGAI Responses using Google Free API
    func sendMessage() {
        guard !userInput.isEmpty else { return }

        if userInput.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "ainal reset" {
            aiQuestionCount = 0
            isPremiumUser = false
            let fullText = "✅ free 10 questions"
            messages.append((fullText, false))
            var animatedText = ""
            Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
                if animatedText.count < fullText.count {
                    let index = fullText.index(fullText.startIndex, offsetBy: animatedText.count)
                    animatedText.append(fullText[index])
                    if let lastIdx = messages.indices.last, messages[lastIdx].1 == false {
                        messages[lastIdx].0 = animatedText
                    } else {
                        messages.append((animatedText, false))
                    }
                } else {
                    timer.invalidate()
                }
            }
            userInput = ""
            return
        }
        if userInput.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "ainal premium" {
            aiQuestionCount = 0
            isPremiumUser = true
            let fullText = "✅ premium user"
            messages.append((fullText, false))
            var animatedText = ""
            Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
                if animatedText.count < fullText.count {
                    let index = fullText.index(fullText.startIndex, offsetBy: animatedText.count)
                    animatedText.append(fullText[index])
                    if let lastIdx = messages.indices.last, messages[lastIdx].1 == false {
                        messages[lastIdx].0 = animatedText
                    } else {
                        messages.append((animatedText, false))
                    }
                } else {
                    timer.invalidate()
                }
            }
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
                let fullText = "❗ You’ve reached your 10 free questions today. Upgrade to continue."
                var animatedText = ""
                Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
                    if animatedText.count < fullText.count {
                        let index = fullText.index(fullText.startIndex, offsetBy: animatedText.count)
                        animatedText.append(fullText[index])
                        if let lastIdx = messages.indices.last, messages[lastIdx].1 == false {
                            messages[lastIdx].0 = animatedText
                        } else {
                            messages.append((animatedText, false))
                        }
                    } else {
                        timer.invalidate()
                    }
                }
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
        let cleanedQuestion = question
            .replacingOccurrences(of: "**", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        // Pull full systemMessage from training.swift
        let fullSystemPrompt = systemMessageIntro + systemMessageTeachingGuide + systemMessageMultiplicationExamples + systemMessageDivisionExamples + systemMessageBackground

        let prompt = "\(systemLanguage)\n\n\(fullSystemPrompt)\n\nUser: \(cleanedQuestion)"

        let body: [String: Any] = [
            "contents": [
                ["parts": [["text": prompt]]]
            ],
            "generationConfig": [
                "temperature": 0.2,
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

// MARK: - Pastel Color Helper
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 255, 255, 255)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
