//
//  addEXP.swift
//  SIGAI-v3
//
//  Created by Ainal syazwan Itamta on 16/03/2025.
//

import SwiftUI
import CoreGraphics

struct EXPManager {
    @AppStorage("totalLetters") static var totalLetters: Int = 6 // Persisted storage
    @AppStorage("expThreshold") static var expThreshold: Double = 100.0 // Initial EXP required to level up
    @AppStorage("expProgress") static var expProgress: Double = 0.0 // Current EXP
    @AppStorage("level") static var level: Int = 1 // User's current level
}

func calculateSigaiProgress() -> [Bool] {
    let step = EXPManager.expThreshold / Double(EXPManager.totalLetters) // Each letter unlocks at equal intervals

    return (0..<EXPManager.totalLetters).map { index in
        EXPManager.expProgress >= Double(index + 1) * step
    }
}

func sigaiProgressBar(appLanguage: String) -> some View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    let progress = EXPManager.expProgress / EXPManager.expThreshold // Normalize to 0-1

    return VStack(alignment: .leading) {
        //Text("SIGAI®")
        //    .font(.system(size: 40, weight: .bold, design: .rounded))

        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 18)
                    .foregroundColor(isDarkMode ? Color.black : Color(red: 235/255, green: 250/255, blue: 255/255))
                    .cornerRadius(5)

                LinearGradient(
                    gradient: Gradient(colors: isDarkMode ? [
                        Color.black,
                        Color.yellow
                    ] : [
                        Color(red: 220/255, green: 245/255, blue: 255/255), // soft blue
                        Color(red: 255/255, green: 220/255, blue: 235/255)  // soft pink
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(width: geo.size.width * CGFloat(progress), height: 20)
                .cornerRadius(5)
            
                HStack {
                    Text("\(Int(progress * 100))%")
                        .font(.system(size: 7, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.leading)
                    
                    Text(appLanguage == "ms" ? "Tahap \(EXPManager.level)" : "Level \(EXPManager.level)")
                        .font(.system(size: 7, weight: .bold, design: .rounded))
                        .foregroundColor(isDarkMode ? Color.yellow : .blue)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing)
                }
            }
            .frame(height: 20)
        }
        .frame(maxWidth: .infinity, minHeight: 20, maxHeight: 20)
    }
}


func addEXP() {
    withAnimation {
        EXPManager.expProgress += 20 // Increase EXP per correct answer

        if EXPManager.expProgress >= EXPManager.expThreshold {
            EXPManager.expProgress = 0  // Reset EXP when full
            EXPManager.expThreshold *= 1.2 // Increase EXP required for the next level
            EXPManager.level += 1 // Increase level by 1
        }
    }
}
