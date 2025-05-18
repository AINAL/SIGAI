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
    @AppStorage("isPremiumUser") var isPremiumUser: Bool = false
    
    @State private var showLanguageMenu = false
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    @State private var selectedTab = 0
    
    @State private var showLockedAlert = false
    
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
                        
                        // BACKGROUND STARS
                        // Stars
                        if isDarkMode {
                            if horizontalSizeClass == .regular {
                                StarScatterShapeLong()
                                    .fill(Color.yellow.opacity(0.8))
                                    .shadow(color: Color.yellow.opacity(0.4), radius: 4, x: 0, y: 2)
                                    .frame(height: 70)
                                    .offset(x: cloudOffset3)
                            } else {
                                StarScatterShape()
                                    .fill(Color.yellow.opacity(0.8))
                                    .shadow(color: Color.yellow.opacity(0.4), radius: 4, x: 0, y: 2)
                                    .frame(height: 70)
                                    .offset(x: cloudOffset3)
                            }
                        }

                        // BACKGROUND CLOUD
                        if horizontalSizeClass == .regular {
                            CloudShapeBLong()
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
                        } else {
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
                        }

                        // MIDDLE CLOUD
                        if horizontalSizeClass == .regular {
                            CloudShapeMLong()
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
                        } else {
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
                        }

                        // FOREGROUND CLOUD
                        if horizontalSizeClass == .regular {
                            CloudShapeFLong()
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
                        } else {
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
                        }

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
            TabView(selection: $selectedTab) {
                SIGAIHomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text(appLanguage == "ms" ? "Laman Utama" : "Home")
                    }
                    .tag(0)

                Group {
                    if isPremiumUser {
                        GeometryReader { geometry in
                            darabTabView(geometry: geometry)
                        }
                    } else {
                        ZStack {
                            LinearGradient(
                                gradient: Gradient(colors: isDarkMode ?
                                                   [Color.black, Color.white] :
                                                   [Color(red: 200/255, green: 230/255, blue: 255), Color(red: 210/255, green: 240/255, blue: 255/255), .white]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .ignoresSafeArea()
                            Color.clear
                                .onAppear {
                                    showLockedAlert = true
                                }
                        }
                        .alert(isPresented: $showLockedAlert) {
                            Alert(
                                title: Text("Premium Feature"),
                                message: Text("This feature is locked. Upgrade to Premium to access."),
                                primaryButton: .default(Text("Upgrade"), action: {
                                    // Trigger IAP
                                }),
                                secondaryButton: .cancel(Text("OK"), action: {
                                    selectedTab = 0
                                })
                            )
                        }
                    }
                }
                .tabItem {
                    Image(systemName: (!isPremiumUser ? "lock.fill" : "multiply"))
                    Text(appLanguage == "ms" ? "Darab" : "Multiply")
                }
                .tag(1)

                GeometryReader { geometry in
                    ModeView(geometry: geometry)
                }
                .tabItem {
                    Image(systemName: "book.fill")
                    Text(appLanguage == "ms" ? "Mod Berpandu" : "Guided Mode")
                }
                .tag(2)

                Group {
                    if isPremiumUser {
                        GeometryReader { geometry in
                            bahagiTabView(geometry: geometry)
                        }
                    } else {
                        ZStack {
                            LinearGradient(
                                gradient: Gradient(colors: isDarkMode ?
                                                   [Color.black, Color.white] :
                                                   [Color(red: 200/255, green: 230/255, blue: 255), Color(red: 210/255, green: 240/255, blue: 255/255), .white]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .ignoresSafeArea()
                            Color.clear
                                .onAppear {
                                    showLockedAlert = true
                                }
                        }
                        .alert(isPresented: $showLockedAlert) {
                            Alert(
                                title: Text("Premium Feature"),
                                message: Text("This feature is locked. Upgrade to Premium to access."),
                                primaryButton: .default(Text("Upgrade"), action: {
                                    // Trigger IAP
                                }),
                                secondaryButton: .cancel(Text("OK"), action: {
                                    selectedTab = 0
                                })
                            )
                        }
                    }
                }
                .tabItem {
                    Image(systemName: (!isPremiumUser ? "lock.fill" : "divide"))
                    Text(appLanguage == "ms" ? "Bahagi" : "Divide")
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
            .preferredColorScheme(.light)
            
            //if !isPremiumUser {
             //   BannerAdView(adUnitID: "ca-app-pub-5767874163080300/8639376065")
             //       .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
            //}
        }
    }

    @ViewBuilder
    func lockedTabView() -> some View {
        VStack(spacing: 20) {
            Image(systemName: "lock.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
                .padding()
                .background(Circle().fill(Color.orange.opacity(0.8)))

            Text("Unlock this feature with Premium.")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)

            Button(action: {
                // Trigger upgrade flow here
            }) {
                Text("Upgrade Now")
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: colorScheme == .dark ?
                                   [Color.black, Color.white] :
                                   [Color(red: 200/255, green: 230/255, blue: 255), Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .cornerRadius(20)
        .padding()
    }
}
