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

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // Welcome Title
                    Text(appLanguage == "ms" ? "Selamat Datang" : "Welcome")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .center) // Center the text horizontally
                        .padding(.vertical, 30)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.6), Color.blue.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(15)
                        .shadow(radius: 10)
                        .padding(.horizontal, 20)
                    
                    
                    // Introduction to SIGAI
                    SectionView(title: appLanguage == "ms" ? "Apa itu SIGAI?" : "What is SIGAI?",
                                description: appLanguage == "ms" ? "SIGAI adalah kaedah inovatif untuk memudahkan operasi darab dan bahagi tanpa perlu menghafal sifir." :
                                "SIGAI is an innovative method for simplifying multiplication and division without memorizing times tables.")

                    // How SIGAI Works
                    SectionView(title: appLanguage == "ms" ? "Bagaimana SIGAI Berfungsi?" : "How Does SIGAI Work?",
                                description: appLanguage == "ms" ? "Kaedah SIGAI menggunakan garisan dan simbol untuk menggambarkan pengiraan darab dan bahagi secara visual." :
                                "SIGAI uses lines and symbols to visually represent multiplication and division calculations.")

                    // Benefits of Using SIGAI
                    SectionView(title: appLanguage == "ms" ? "Kelebihan Menggunakan SIGAI" : "Benefits of Using SIGAI",
                                description: appLanguage == "ms" ? "SIGAI membantu pelajar memahami konsep matematik dengan lebih baik dan meningkatkan keyakinan mereka." :
                                "SIGAI helps students understand mathematical concepts better and boosts their confidence.")

                    // SIGAI Learning Stages
                    SectionView(title: appLanguage == "ms" ? "Peringkat Pembelajaran SIGAI" : "SIGAI Learning Stages",
                                description: appLanguage == "ms" ? "Terdapat 6 fasa dalam SIGAI Darab dan 3 fasa dalam SIGAI Bahagi untuk pemahaman bertahap." :
                                "There are 6 phases in SIGAI Multiplication and 3 phases in SIGAI Division for progressive learning.")

                    // Success Stories
                    SectionView(title: appLanguage == "ms" ? "Kejayaan SIGAI" : "SIGAI Success Stories",
                                description: appLanguage == "ms" ? "SIGAI telah menerima pelbagai anugerah inovasi dan digunakan secara meluas dalam pendidikan." :
                                "SIGAI has received various innovation awards and is widely used in education.")
                    
                    // Grid of Tab Links
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        NavigationLink(destination: TutorialView()) {
                            HomeTabButton(title: appLanguage == "ms" ? "Tutorial" : "Tutorial", icon: "pencil")
                        }
                        
                        NavigationLink(destination: HistoryView()) {
                            HomeTabButton(title: appLanguage == "ms" ? "Sejarah" : "History", icon: "book.fill")
                        }
                        
                        NavigationLink(destination: PDFViewerView()) {
                            HomeTabButton(title: appLanguage == "ms" ? "SIGAI.pdf" : "SIGAI.pdf", icon: "doc.text.fill")
                        }
                        
                        NavigationLink(destination: SettingsView()) {
                            HomeTabButton(title: appLanguage == "ms" ? "Tetapan" : "Settings", icon: "gearshape.fill")
                        }
                    }
                    .padding()
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]),
                               startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
        }
    }
}
