//
//  ContentView.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 13/03/2025.
//


import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
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
    
    @State private var showLanguageMenu = false
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    @State private var selectedTab = 0
    
    enum MathMode {
        case multiplication
        case division
    }
    
    // Multi-layer cloud animation state variables
    @State private var cloudOffset1: CGFloat = 0.0
    @State private var cloudOffset2: CGFloat = 0.0
    @State private var cloudOffset3: CGFloat = 0.0

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
                    ZStack {
                        // BACKGROUND CLOUD
                        CloudShapeB()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: isDarkMode ?
                                                    [Color.gray.opacity(0.5), Color.black.opacity(0.5)] :
                                                    [Color.white.opacity(0.6), Color(red: 224/255, green: 247/255, blue: 250/255).opacity(0.6)]),
                                startPoint: .top,
                                endPoint: .bottom
                            ))
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                            .frame(height: 50)
                            .offset(x: cloudOffset1)

                        // MIDDLE CLOUD
                        CloudShapeM()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: isDarkMode ?
                                                    [Color.gray.opacity(0.7), Color.black.opacity(0.7)] :
                                                    [Color.white, Color(red: 224/255, green: 247/255, blue: 250/255)]),
                                startPoint: .top,
                                endPoint: .bottom
                            ))
                            .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 3)
                            .frame(height: 60)
                            .offset(x: cloudOffset2)

                        // FOREGROUND CLOUD
                        CloudShapeF()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: isDarkMode ?
                                                    [Color.gray.opacity(0.9), Color.black.opacity(0.9)] :
                                                    [Color.white, Color(red: 224/255, green: 247/255, blue: 250/255)]),
                                startPoint: .top,
                                endPoint: .bottom
                            ))
                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                            .frame(height: 70)
                            .offset(x: cloudOffset3)
                        
                        

                        // HStack for Logo and Buttons remains the same
                        HStack {
                            Button(action: {
                                showLanguageMenu = true
                            }) {
                                Image(isDarkMode ? "Sigai-removebg-preview-2" : "Sigai-removebg-preview")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 125, height: 105)
                                    .offset(x: -10)
                            }
                            .confirmationDialog("Select Language", isPresented: $showLanguageMenu, titleVisibility: .visible) {
                                Button("🇲🇾 Malay") { appLanguage = "ms" }
                                Button("🇬🇧 English") { appLanguage = "en" }
                                Button("Cancel", role: .cancel) { }
                            }

                            Spacer()

                            Button(action: {
                                isDarkMode.toggle()
                            }) {
                                Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                                    .font(.title)
                                    .foregroundColor(isDarkMode ? .yellow : .orange)
                            }
                            .padding(.trailing, 15)
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 50)
                    .onAppear {
                        withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: true)) {
                            cloudOffset1 = 35
                        }
                        withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: true)) {
                            cloudOffset2 = -40
                        }
                        withAnimation(Animation.linear(duration: 60).repeatForever(autoreverses: true)) {
                            cloudOffset3 = 2
                        }
                    }

                    mainContent()
                }
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: isDarkMode ?
                                            [Color.black, Color.gray] :
                                            [Color(red: 255/255, green: 200/255, blue: 230/255), Color.white]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                )
            }
        }
    }
    
    func mainContent() -> some View {
        VStack(spacing: 0) {
            //BannerAdView(adUnitID: "ca-app-pub-3940256099942544/2934735716") //testing ads
            //BannerAdView(adUnitID: "ca-app-pub-5767874163080300/8639376065") //cannot use need to upload at appstore
                //.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                //.padding(.bottom, 5)
            TabView(selection: $selectedTab) {
                SIGAIHomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text(appLanguage == "ms" ? "Laman Utama" : "Home")
                    }
                    .tag(0)

                GeometryReader { geometry in
                    darabTabView(geometry: geometry)
                }
                .tabItem {
                    Image(systemName: "multiply")
                    Text(appLanguage == "ms" ? "Darab" : "Multiply")
                }
                .tag(1)

                GeometryReader { geometry in
                    ModeView(geometry: geometry)
                }
                .tabItem {
                    Image(systemName: "book.fill")
                    Text(appLanguage == "ms" ? "Mod Berpandu" : "Guided Mode" )
                }
                .tag(2)

                GeometryReader { geometry in
                    bahagiTabView(geometry: geometry)
                }
                .tabItem {
                    Image(systemName: "divide")
                    Text(appLanguage == "ms" ? "Bahagi" : "Divide" )
                }
                .tag(3)

                SIGAI()
                    .tabItem {
                        Image(systemName: "brain.head.profile")
                        Text(appLanguage == "ms" ? "Tanya SIGAI" : "Ask SIGAI")
                    }
                    .tag(4)
            }
            .tint(isDarkMode ? .yellow : .blue)
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
