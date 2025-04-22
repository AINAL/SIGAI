//
//  Mode.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//

import SwiftUI

extension ContentView {
    func ModeView(geometry: GeometryProxy) -> some View {
        VStack {
            
            VStack(spacing: 5) {
                
                Text(appLanguage == "ms" ? "Mod Berpandu" : "Guided Mode")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.top, 305)
                
                HStack {
                    Button(action: {
                        let tipsMs = [
                            "Pilih warna ikut kod: 🟣 -100, 🟡 -10, 🔵 10, 🟢 1, ⚫ 0",
                            "Untuk darab, butang kunci telah dimatikan kerana tidak perlu untuk operasi darab",
                            "Untuk bahagi, lukis garisan menegak dahulu, kunci (warna kelabu), kemudian lukis garisan horizontal",
                            "Tekan 'Hantar' untuk semak jawapan!",
                            "Tekan 'Seterusnya' untuk skip ke soalan seterusnya"
                        ]
                        
                        let tipsEn = [
                            "Pick colors based on code: 🟣 -100, 🟡 -10, 🔵 10, 🟢 1, ⚫ 0",
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
                .padding(.horizontal, 5)
                
                HStack {
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.horizontal, 20)
                
                VStack {
                    sigaiProgressBar(appLanguage: appLanguage)
                        .frame(maxWidth: .infinity)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(showFeedback ? (showCorrectOverlay ? Color.green.opacity(0.3) : Color.red.opacity(0.3)) : Color.gray.opacity(0.2))
                            )
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity)
                            .padding(5)
                        
                        VStack {
                            if mode == .multiplication {
                                Text(appLanguage == "ms" ? "Hasil Darab: \(question)" : "Multiplication Result: \(question)")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                
                                Text("\(countIntersections())")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(5)
                                    .background(Color.clear)
                                    .cornerRadius(5)
                                    .frame(width: 200, height: 40)
                                    .multilineTextAlignment(.center)
                            } else {
                                Text(appLanguage == "ms" ? "Hasil Bahagi (\(detectedVerticalLines) garis): \(question)" : "Division Result (\(detectedVerticalLines) line/s): \(question)")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                
                                Text(String(format: "%.6f", countDivisions()))
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(5)
                                    .background(Color.clear)
                                    .cornerRadius(5)
                                    .frame(width: 300, height: 40)
                                    .multilineTextAlignment(.center)
                            }
                            
                            Text(appLanguage == "ms" ? "Lukis jawapan." : "Draw your answer.")
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.horizontal, 20)
                        }
                        .padding(5)
                    }
                    .padding(.horizontal)
                }
                HStack(spacing: 20) {
                    
                    Button(action: {
                        if mode == .multiplication {
                            if countIntersections() == correctAnswer {
                                addEXP()
                                showFeedback = true
                                showCorrectOverlay = true // Change box to green
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    showCorrectOverlay = false
                                    showFeedback = false  // Reset color
                                    generateQuestion()    // Change question
                                }
                            } else {
                                showFeedback = true
                                showCorrectOverlay = false // Change box to red
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    showFeedback = false  // Reset color
                                }
                            }
                        } else {
                            var temp_division = countDivisions() - correctAnswerB
                            if temp_division < 0 { temp_division *= -1 }
                            if temp_division < 0.00001 {
                                addEXP()
                                showFeedback = true
                                showCorrectOverlay = true // Change box to green
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    showCorrectOverlay = false
                                    showFeedback = false  // Reset color
                                    generateQuestion()    // Change question
                                }
                            } else {
                                showFeedback = true
                                showCorrectOverlay = false // Change box to red
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    showFeedback = false  // Reset color
                                }
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "paperplane.fill") // ✈️ Symbol for Submit
                                .font(.title2)
                            Text(appLanguage == "ms" ? "Hantar" : "Submit")
                                .font(.headline)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    
                    Button(action: {
                        // Clear drawing before generating new question
                        paths.removeAll()
                        colors.removeAll()
                        currentPath = Path()
                        lockedVerticalLines = nil // Reset locked lines
                        
                        generateQuestion() // Generate a new question
                    }) {
                        HStack {
                            Image(systemName: "questionmark.circle.fill") // ? Symbol for Submit
                                .font(.title2)
                            Text(appLanguage == "ms" ? "Seterusnya" : "Next")
                                .font(.headline)
                        }
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                        .frame(minWidth: 100, maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 20)
                
                // Removed inline feedback message in favor of overlay on drawing canvas
            }
            .padding(.top, geometry.safeAreaInsets.top + 20)
            
            Spacer()
            
            ZStack {
                drawingCanvas(geometry: geometry)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
        }
        .onAppear {
            generateQuestion()
            paths.removeAll()
            colors.removeAll()
            currentPath = Path()
        }
        .frame(width: geometry.size.width, height: geometry.size.height)
        .edgesIgnoringSafeArea(.all)
        .preferredColorScheme(.light)
        .background(Color.white)
    }
}
