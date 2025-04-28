//
//  Home.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//

import SwiftUI
import PDFKit

struct SIGAIHomeView: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("appLanguage") private var appLanguage: String = "ms" // Default language is Malay
    @State private var showSetting: Bool = false
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // Welcome Title
                    Text(appLanguage == "ms" ? "Selamat Datang" : "Welcome")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor((isDarkMode == true) ? .yellow : .blue)
                        .shadow(color: (isDarkMode == true) ? .black.opacity(0.3) : .clear, radius: 2)
                        .frame(maxWidth: .infinity, alignment: .center) // Center the text horizontally
                        .padding(.vertical, 30)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: isDarkMode ?
                                    [Color(red: 0.2, green: 0.2, blue: 0.2), Color(red: 0.1, green: 0.1, blue: 0.1)] :
                                    [Color(red: 1.0, green: 0.8, blue: 0.9), Color(red: 210/255, green: 240/255, blue: 255/255)]
                                ),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .cornerRadius(15)
                        .shadow(color: Color.blue.opacity(0.2), radius: 5, x: 0, y: 2)
                        .padding(.horizontal, 20)
                        .onTapGesture {
                            withAnimation {
                                showSetting.toggle()
                            }
                        }

                    // Unlock/Restore Buttons - vertical, full width, pastel, rounded, shadow
                    if showSetting {
                        VStack(spacing: 10) {
                            NavigationLink(destination: TutorialView()) {
                                HStack {
                                    Image(systemName: "pencil")
                                        .font(.system(size: 18, weight: .bold))
                                    Text(appLanguage == "ms" ? "Tutorial" : "Tutorial")
                                        .font(.system(size: 18, weight: .bold))
                                }
                                .foregroundColor((isDarkMode || colorScheme == .dark) ? .white : .primary)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(isDarkMode ? Color(red: 0.6, green: 0.3, blue: 0.4) : Color(red: 255/255, green: 179/255, blue: 186/255)) // Darker pastel pink if dark mode
                                .cornerRadius(15)
                            }
                            
                            NavigationLink(destination: HistoryView()) {
                                HStack {
                                    Image(systemName: "book.fill")
                                        .font(.system(size: 18, weight: .bold))
                                    Text(appLanguage == "ms" ? "Sejarah" : "History")
                                        .font(.system(size: 18, weight: .bold))
                                }
                                .foregroundColor((isDarkMode || colorScheme == .dark) ? .white : .primary)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(isDarkMode ? Color(red: 0.3, green: 0.6, blue: 0.4) : Color(red: 186/255, green: 255/255, blue: 201/255)) // Darker pastel green if dark mode
                                .cornerRadius(15)
                            }
                            
                            NavigationLink(destination: PDFViewerView()) {
                                HStack {
                                    Image(systemName: "doc.text.fill")
                                        .font(.system(size: 18, weight: .bold))
                                    Text(appLanguage == "ms" ? "SIGAI.pdf" : "SIGAI.pdf")
                                        .font(.system(size: 18, weight: .bold))
                                }
                                .foregroundColor((isDarkMode || colorScheme == .dark) ? .white : .primary)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(isDarkMode ? Color(red: 0.6, green: 0.4, blue: 0.2) : Color(red: 255/255, green: 223/255, blue: 186/255)) // Darker pastel orange if dark mode
                                .cornerRadius(15)
                            }
                            
                            NavigationLink(destination: SettingsView()) {
                                HStack {
                                    Image(systemName: "gearshape.fill")
                                        .font(.system(size: 18, weight: .bold))
                                    Text(appLanguage == "ms" ? "Tetapan" : "Settings")
                                        .font(.system(size: 18, weight: .bold))
                                }
                                .foregroundColor((isDarkMode || colorScheme == .dark) ? .white : .primary)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(isDarkMode ? Color(red: 0.3, green: 0.4, blue: 0.6) : Color(red: 186/255, green: 225/255, blue: 255/255)) // Darker pastel blue if dark mode
                                .cornerRadius(15)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    SectionView(
                        title: appLanguage == "ms" ? "Tentang SIGAI" : "About SIGAI",
                        description: appLanguage == "ms" ?
                            "SIGAI ialah kaedah inovatif untuk memudahkan operasi darab dan bahagi menggunakan garisan dan simbol visual. Ia membantu pelajar memahami konsep matematik dengan lebih mudah dan membina keyakinan." :
                            "SIGAI is an innovative method that simplifies multiplication and division using visual lines and symbols. It helps students understand math concepts more easily and build confidence."
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadius(10)

                    // SIGAI Learning Stages
                    SectionView(title: appLanguage == "ms" ? "Belajar & Praktis di Mod Belajar" : "Learn & Practice in Learning Mode",
                                description: appLanguage == "ms" ? "Gunakan Mod Belajar untuk berlatih dan memahami konsep darab dan bahagi dengan lebih mudah." :
                                "Use Learning Mode to practice and understand multiplication and division concepts more easily.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadius(10)

                    // Success Stories - Improved wording and direct navigation to HistoryView
                    VStack(alignment: .leading, spacing: 10) {
                        SectionView(
                            title: appLanguage == "ms" ? "Kejayaan SIGAI" : "SIGAI Success Stories",
                            description: appLanguage == "ms" ?
                                "SIGAI telah membantu ramai pelajar berjaya dalam matematik. Ketahui kisah mereka dengan melihat sejarah pembelajaran." :
                                "SIGAI has helped many students succeed in mathematics. Discover their stories by exploring the learning history."
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadius(10)
                    
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: isDarkMode ?
                                        [Color.black, Color.black, Color.gray] :
                                        [
                                            Color(red: 235/255, green: 250/255, blue: 255/255),
                                            Color(red: 235/255, green: 250/255, blue: 255/255),
                                            Color(red: 220/255, green: 245/255, blue: 255/255), // Very light blue
                                            Color.white,
                                            Color.white,
                                            Color(red: 255/255, green: 220/255, blue: 230/255),  // Softer pink
                                            Color(red: 255/255, green: 220/255, blue: 230/255)  // Softer pink
                                        ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            )
        }
    }
}
