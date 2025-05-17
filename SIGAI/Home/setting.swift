//
//  Setting.swift
//  SIGAI-v3
//
//  Created by Ainal syazwan Itamta on 18/03/2025.
//
import SwiftUI

struct SettingsView: View {
    @State private var showDeleteAlert = false

    var body: some View {
        List {
            Section(header: Text("Legal & Compliance")) {
                Link("Privacy Policy", destination: URL(string: "https://sigai-backend.web.app/privacy-policy.html")!)
                Link("Terms of Use", destination: URL(string: "https://sigai-backend.web.app/term-of-use.html")!)
                NavigationLink("AI Disclaimer", destination: AIDisclaimerView())
            }
            
            Section(header: Text("Data & Privacy")) {
                Text("This app uses Google Gemini API to process user inputs. Some data may be collected and stored temporarily for AI functionality. No personally identifiable information is stored or shared.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                Button("Request Data Deletion") {
                    showDeleteAlert = true
                }
                .foregroundColor(.red)
                .alert(isPresented: $showDeleteAlert) {
                    Alert(
                        title: Text("Data Deletion Request"),
                        message: Text("If you want to request data deletion, please contact support at ainalsyazwan@gmail.com"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }

            Section(header: Text("App Info")) {
                HStack {
                    Text("Version")
                    Spacer()
                    Text(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct AIDisclaimerView: View {
    var body: some View {
        ScrollView {
            Text("This app uses AI-generated content. Responses may not always be accurate. Please verify any critical information before relying on AI-generated results.")
                .padding()
        }
        .navigationTitle("AI Disclaimer")
    }
}
