//
//  Mode.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//

import SwiftUI
import AVFoundation

extension ContentView {
    func playSound(success: Bool) {
        if success {
            let soundID: SystemSoundID = 1335 // Apple Pay Success-like sound
            AudioServicesPlaySystemSound(soundID)
        } else {
            let soundID: SystemSoundID = 1006 // Strong error thunk
            AudioServicesPlaySystemSound(soundID)
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate) // Vibrate when wrong
        }
    }
    func ModeView(geometry: GeometryProxy) -> some View {
        ZStack {
            LinearGradient (
                gradient: Gradient(colors: isDarkMode ? [
                    Color.black,
                    Color(red: 230/255, green: 230/255, blue: 230/255),
                    Color.white,
                    Color(red: 245/255, green: 245/255, blue: 245/255),
                    Color.white,
                    Color(red: 250/255, green: 250/255, blue: 250/255),
                    Color.white
                ] : [
                    Color(red: 235/255, green: 250/255, blue: 255/255),
                    Color.white,
                    Color(red: 220/255, green: 245/255, blue: 255/255), // Very light blue
                    Color.white,
                    Color(red: 255/255, green: 220/255, blue: 230/255)  // Softer pink
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                sigaiProgressBar(appLanguage: appLanguage)
                    .frame(maxWidth: .infinity)
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: isDarkMode ? [
                                        Color(red: 50/255, green: 50/255, blue: 100/255), // Dark Blue
                                        Color(red: 80/255, green: 80/255, blue: 150/255)  // Slightly lighter Dark Blue
                                    ] : [
                                        Color(red: 1.0, green: 0.8, blue: 0.9), // Soft Pink
                                        Color(red: 210/255, green: 240/255, blue: 255/255) // Light Blue
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 3)
                            .frame(maxWidth: .infinity)
                        VStack {
                            if mode == .multiplication {
                                Text(appLanguage == "ms" ? "Hasil Darab: \(question)" : "Multiplication Result: \(question)")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(isDarkMode ? Color.yellow.opacity(0.8) : Color.blue.opacity(0.7))
                                    .shadow(color: (isDarkMode ? Color.yellow.opacity(0.2) : Color.blue.opacity(0.2)), radius: 5, x: 0, y: 2)
                                Text("\(countIntersections())")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .background(Color.clear)
                                    .cornerRadius(5)
                                    .frame(width: 200, height: 40)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(isDarkMode ? Color.yellow.opacity(0.8) : Color.blue.opacity(0.7))
                                    .shadow(color: (isDarkMode ? Color.yellow.opacity(0.2) : Color.blue.opacity(0.2)), radius: 5, x: 0, y: 2)
                            } else {
                                Text(appLanguage == "ms" ? "Hasil Bahagi (\(detectedVerticalLines) garis): \(question)" : "Division Result (\(detectedVerticalLines) line/s): \(question)")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(isDarkMode ? Color.yellow.opacity(0.8) : Color.blue.opacity(0.7))
                                    .shadow(color: (isDarkMode ? Color.yellow.opacity(0.2) : Color.blue.opacity(0.2)), radius: 5, x: 0, y: 2)
                                Text(String(format: "%.6f", countDivisions()))
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .background(Color.clear)
                                    .cornerRadius(5)
                                    .frame(width: 300, height: 40)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(isDarkMode ? Color.yellow.opacity(0.8) : Color.blue.opacity(0.7))
                                    .shadow(color: (isDarkMode ? Color.yellow.opacity(0.2) : Color.blue.opacity(0.2)), radius: 5, x: 0, y: 2)
                            }
                            Text(appLanguage == "ms" ? "Lukis jawapan." : "Draw your answer.")
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .foregroundColor(isDarkMode ? Color.white.opacity(0.8) : .secondary)
                                .shadow(color: isDarkMode ? Color.white.opacity(0.2) : Color.clear, radius: 5, x: 0, y: 2)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.horizontal, 20)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)
                .padding(.top, geometry.safeAreaInsets.top)

                HStack {
                    Button(action: {
                        let tipsMs = [
                            "Pilih warna ikut kod: 🟣 -100, 🟡 -10, ⚫ 0, 🟢 1, 🔵 10, 🔴 100",
                            "Untuk darab, butang kunci telah dimatikan kerana tidak perlu untuk operasi darab",
                            "Untuk bahagi, lukis garisan menegak dahulu, kunci (warna kelabu), kemudian lukis garisan horizontal",
                            "Tekan 'Hantar' untuk semak jawapan!",
                            "Tekan 'Seterusnya' untuk skip ke soalan seterusnya"
                        ]
                        
                        let tipsEn = [
                            "Pick colors based on code: 🟣 -100, 🟡 -10, ⚫ 0, 🟢 1, 🔵 10, 🔴 100",
                            "For, multiplication, lock button is disabled due to not applicable",
                            "For division, draw vertical lines first, locked (grey color), then draw horizontal lines",
                            "Press 'Submit' to check the answer!",
                            "Press 'Next' to skip to the next question"
                        ]
                        
                        let tips = appLanguage == "ms" ? tipsMs : tipsEn
                        currentTip = tips[currentTipIndex]
                        currentTipIndex = (currentTipIndex + 1) % tips.count
                        showTipAlert = true
                    }) {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.orange)
                    }
                    
                    Button(action: {
                        if !paths.isEmpty {
                            paths.removeLast()
                            colors.removeLast()
                        }
                    }) {
                        Image(systemName: "arrow.uturn.backward.circle.fill")
                            .font(.system(size: 32))
                            .background(Color.clear)
                            .foregroundColor(.gray)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                    }
                    
                    Menu {
                        Button(action: {
                            if EXPManager.level >= 20 {
                                selectedColor = .red
                            }
                        }) {
                            Label(EXPManager.level >= 20 ? "🔴 100" : (appLanguage == "ms" ? "🔴 Buka pada tahap 20" : "🔴 Unlock at Level 20"),
                                  systemImage: EXPManager.level >= 20 ? "circle.fill" : "lock.circle.fill")
                            .foregroundColor(EXPManager.level >= 20 ? .red : .gray)
                        }
                        .disabled(EXPManager.level < 20)
                        
                        Button(action: {
                            if EXPManager.level >= 10 {
                                selectedColor = .blue
                            }
                        }) {
                            Label(EXPManager.level >= 10 ? "🔵 10" : (appLanguage == "ms" ? "🔵 Buka pada tahap 10" : "🔵 Unlock at Level 10"),
                                  systemImage: EXPManager.level >= 10 ? "circle.fill" : "lock.circle.fill")
                            .foregroundColor(EXPManager.level >= 10 ? .blue : .gray)
                        }
                        .disabled(EXPManager.level < 10)
                        
                        Button(action: { selectedColor = .green }) {
                            Label("🟢 1", systemImage: "circle.fill")
                                .foregroundColor(.green)
                        }
                        
                        Button(action: { selectedColor = .gray }) {
                            Label("⚫ 0", systemImage: "circle.fill")
                                .foregroundColor(.gray)
                        }
                        
                        if mode == .division {
                            Button(action: {
                                if EXPManager.level >= 30 {
                                    selectedColor = .yellow
                                }
                            }) {
                                Label(EXPManager.level >= 30 ? "🟡 -10" : (appLanguage == "ms" ? "🟡 Buka pada tahap 30" : "🟡 Unlock at Level 30"),
                                      systemImage: EXPManager.level >= 30 ? "circle.fill" : "lock.circle.fill")
                                .foregroundColor(EXPManager.level >= 30 ? .yellow : .gray)
                            }
                            .disabled(EXPManager.level < 30)
                            
                            Button(action: {
                                if EXPManager.level >= 40 {
                                    selectedColor = .purple
                                }
                            }) {
                                Label(EXPManager.level >= 40 ? "🟣 -100" : (appLanguage == "ms" ? "🟣 Buka pada tahap 40" : "🟣 Unlock at Level 40"),
                                      systemImage: EXPManager.level >= 40 ? "circle.fill" : "lock.circle.fill")
                                .foregroundColor(EXPManager.level >= 40 ? .purple : .gray)
                            }
                            .disabled(EXPManager.level < 40)
                        }
                    } label: {
                        Image(systemName: "paintpalette.fill")
                            .font(.system(size: 32))
                            .foregroundColor(
                                selectedColor == .red ? Color.red :
                                    selectedColor == .blue ? Color.blue :
                                    selectedColor == .green ? Color.green :
                                    selectedColor == .yellow ? Color.yellow :
                                    selectedColor == .purple ? Color.purple :
                                    Color.gray
                            )
                    }
                    
                    Button(action: {
                        mode = (mode == .multiplication) ? .division : .multiplication
                        generateQuestion() // Generate a new question when mode changes
                    }) {
                        Image(systemName: mode == .multiplication ? "divide.circle.fill" : "multiply.circle.fill")
                            .font(.system(size: 32)) // Bigger size for visibility
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: {
                        if mode == .multiplication {
                            if lockedVerticalLines == nil {
                                lockedVerticalLines = detectedVerticalLines
                            } else {
                                lockedVerticalLines = nil
                            }
                            
                            // Temporarily change lock color to red for 1 second
                            DispatchQueue.main.async {
                                isLocked = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    isLocked = false
                                }
                            }
                        } else {
                            if lockedVerticalLines == nil {
                                lockedVerticalLines = detectedVerticalLines
                            } else {
                                lockedVerticalLines = nil
                            }
                        }
                    }) {
                        Image(systemName: (mode == .multiplication) ? "lock.fill" : (lockedVerticalLines == nil ? "lock.open.fill" : "lock.fill"))
                            .font(.system(size: 36))
                            .foregroundColor(mode == .multiplication ? (isLocked ? .red : .gray) : (lockedVerticalLines == nil ? .blue : .gray))
                    }
                    .disabled(mode == .multiplication && isLocked)
                    
                    Button(action: {
                        paths.removeAll()
                        colors.removeAll()
                        currentPath = Path()
                        isLocked = false
                        lockedVerticalLines = nil // Unlock when clearing
                    }) {
                        Image(systemName: "eraser.fill")
                            .font(.system(size: 32))
                            .background(Color.clear)
                            .foregroundColor(.gray)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                    }
                }
                .alert(isPresented: $showTipAlert) {
                    Alert(
                        title: Text("💡 Tip"),
                        message: Text(currentTip),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .padding(.horizontal)

                HStack(spacing: 20) {
                    Button(action: {
                        if mode == .multiplication {
                            if countIntersections() == correctAnswer {
                                addEXP()
                                showFeedback = true
                                showCorrectOverlay = true
                                playSound(success: true)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    showCorrectOverlay = false
                                    showFeedback = false
                                    generateQuestion()
                                }
                            } else {
                                showFeedback = true
                                showCorrectOverlay = false
                                playSound(success: false)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    showFeedback = false
                                }
                            }
                        } else {
                            var temp_division = countDivisions() - correctAnswerB
                            if temp_division < 0 { temp_division *= -1 }
                            if temp_division < 0.00001 {
                                addEXP()
                                showFeedback = true
                                showCorrectOverlay = true
                                playSound(success: true)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    showCorrectOverlay = false
                                    showFeedback = false
                                    generateQuestion()
                                }
                            } else {
                                showFeedback = true
                                showCorrectOverlay = false
                                playSound(success: false)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    showFeedback = false
                                }
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "paperplane.fill")
                            Text(appLanguage == "ms" ? "Hantar" : "Submit")
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(22)
                        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                        .frame(height: 45)
                    }

                    Button(action: {
                        paths.removeAll()
                        colors.removeAll()
                        currentPath = Path()
                        isLocked = false
                        lockedVerticalLines = nil
                        generateQuestion()
                    }) {
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                            Text(appLanguage == "ms" ? "Seterusnya" : "Next")
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(22)
                        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                        .frame(height: 45)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Spacer()

                ZStack {
                        drawingCanvas(geometry: geometry)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                }
            }
        }
        .onAppear {
            generateQuestion()
            paths.removeAll()
            colors.removeAll()
            currentPath = Path()
        }
        //.frame(width: geometry.size.width, height: geometry.size.height)
        .edgesIgnoringSafeArea(.all)
        .preferredColorScheme(.light)
        //.background(Color.white)
    }
}
