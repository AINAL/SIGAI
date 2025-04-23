//
//  ContentView.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 13/03/2025.
//

import SwiftUI

struct ContentView: View {
    @State var currentTipIndex = 0
    @State var showTipAlert = false
    @State var currentTip = ""
    @State var question: String = ""
    @State var correctAnswer: Int = 0
    @State var correctAnswerB: Double = 0
    @State var userAnswer: String = ""
    @State var showFeedback: Bool = false
    @State var showCorrectMessage: Bool = false
    @State var showCorrectOverlay: Bool = false
    @State var showLightBulb: Bool = false
    @State var showWrongMark: Bool = false
    @State var isLocked: Bool = false
    @State var detectedVerticalLines: Int = 0
    @State var lockedVerticalLines: Int? = nil
    @State var showSplash = true
    @State var paths: [Path] = []
    @State var colors: [Color] = []
    @State var currentPath = Path()
    @State var selectedColor: Color = .gray
    @State var mode: MathMode = .multiplication // Toggle between multiplication and divisio
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // Detects landscape mode
    @AppStorage("appLanguage") var appLanguage: String = "ms" // Default to Malay
    @AppStorage("expProgress") var expProgress: Double = 0.0
    
    enum MathMode {
        case multiplication
        case division
    }
    
    var body: some View {
        ZStack {
            if showSplash {
                SplashScreenView()
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                VStack(spacing: 0) {
                    HStack {
                        Image("Sigai-removebg-preview") // Ensure you have 'Sigai_logo' in Assets.xcassets
                            .resizable()
                            .scaledToFit()
                            .frame(width: 125, height: 105)
                            .offset(x: -10) // Adjust the value as needed
                        Spacer()
                        
                        // Language Toggle Button (Top Right)
                        Button(action: {
                            appLanguage = (appLanguage == "ms") ? "en" : "ms"
                        }) {
                            Text(appLanguage == "ms" ? "🇬🇧" : "🇲🇾") // Shows UK flag when Malay is active, vice versa
                                .font(.title)
                                .frame(width: 25, height: 15)
                                .foregroundColor(.blue)
                        }
                        .padding(.trailing, 15)
                    }
                    .padding(3)
                    .frame(height: 30)
                    .background(Color.white)
                    .shadow(radius: 2)
                    .zIndex(1)
                    
                    mainContent()
                }
                .background(Color.white.opacity(0.9))
            }
        }
    }
    
    func mainContent() -> some View {
        VStack(spacing: 0) {
            //BannerAdView(adUnitID: "ca-app-pub-3940256099942544/2934735716") //testing ads
            //BannerAdView(adUnitID: "ca-app-pub-5767874163080300/8639376065") //cannot use need to upload at appstore
                //.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                //.padding(.bottom, 5)
            TabView {
                SIGAIHomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text(appLanguage == "ms" ? "Laman Utama" : "Home")
                            .frame(maxWidth: .infinity)
                    }
                
                GeometryReader { geometry in
                    darabTabView(geometry: geometry)
                }
                .tabItem {
                    Image(systemName: "multiply")
                    Text(appLanguage == "ms" ? "Darab" : "Multiply")
                        .frame(maxWidth: .infinity)
                }
                
                GeometryReader { geometry in
                    ModeView(geometry: geometry)
                }
                .tabItem {
                    Image(systemName: "book.fill")
                    Text(appLanguage == "ms" ? "Mod Berpandu" : "Guided Mode" )
                        .frame(maxWidth: .infinity)
                }
                
                GeometryReader { geometry in
                    bahagiTabView(geometry: geometry)
                }
                .tabItem {
                    Image(systemName: "divide")
                    Text(appLanguage == "ms" ? "Bahagi" : "Divide" )
                        .frame(maxWidth: .infinity)
                }
                
                SIGAI()
                    .tabItem {
                        Image(systemName: "brain.head.profile")
                        Text(appLanguage == "ms" ? "Tanya SIGAI" : "Ask SIGAI")
                            .frame(maxWidth: .infinity)
                    }
            }
            .preferredColorScheme(.light)
            .accentColor(.black) 
        }
    }
}
