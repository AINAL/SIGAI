//
//  Home.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//

import SwiftUI
import PDFKit

struct SIGAIHomeView: View {
    @AppStorage("appLanguage") private var appLanguage: String = "ms" // Default language is Malay
    @State private var showSetting: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // Welcome Title
                    Text(appLanguage == "ms" ? "Selamat Datang" : "Welcome")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(Color.blue.opacity(0.7))
                        .frame(maxWidth: .infinity, alignment: .center) // Center the text horizontally
                        .padding(.vertical, 30)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 1.0, green: 0.8, blue: 0.9),
                                    Color(red: 210/255, green: 240/255, blue: 255/255)
                                ]),
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
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 255/255, green: 179/255, blue: 186/255)) // Light pastel pink
                                .cornerRadius(15)
                            }
                            
                            NavigationLink(destination: HistoryView()) {
                                HStack {
                                    Image(systemName: "book.fill")
                                        .font(.system(size: 18, weight: .bold))
                                    Text(appLanguage == "ms" ? "Sejarah" : "History")
                                        .font(.system(size: 18, weight: .bold))
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 186/255, green: 255/255, blue: 201/255)) // Light pastel green
                                .cornerRadius(15)
                            }
                            
                            NavigationLink(destination: PDFViewerView()) {
                                HStack {
                                    Image(systemName: "doc.text.fill")
                                        .font(.system(size: 18, weight: .bold))
                                    Text(appLanguage == "ms" ? "SIGAI.pdf" : "SIGAI.pdf")
                                        .font(.system(size: 18, weight: .bold))
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 255/255, green: 223/255, blue: 186/255)) // Light pastel orange
                                .cornerRadius(15)
                            }
                            
                            NavigationLink(destination: SettingsView()) {
                                HStack {
                                    Image(systemName: "gearshape.fill")
                                        .font(.system(size: 18, weight: .bold))
                                    Text(appLanguage == "ms" ? "Tetapan" : "Settings")
                                        .font(.system(size: 18, weight: .bold))
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 186/255, green: 225/255, blue: 255/255)) // Light pastel blue
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

                    // SIGAI Learning Stages
                    SectionView(title: appLanguage == "ms" ? "Peringkat Pembelajaran SIGAI" : "SIGAI Learning Stages",
                                description: appLanguage == "ms" ? "Terdapat 6 fasa dalam SIGAI Darab dan 3 fasa dalam SIGAI Bahagi untuk pemahaman bertahap." :
                                "There are 6 phases in SIGAI Multiplication and 3 phases in SIGAI Division for progressive learning.")
                    .frame(maxWidth: .infinity, alignment: .leading)

                    // Success Stories
                    SectionView(title: appLanguage == "ms" ? "Kejayaan SIGAI" : "SIGAI Success Stories",
                                description: appLanguage == "ms" ? "SIGAI telah menerima pelbagai anugerah inovasi dan digunakan secara meluas dalam pendidikan." :
                                "SIGAI has received various innovation awards and is widely used in education.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
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
