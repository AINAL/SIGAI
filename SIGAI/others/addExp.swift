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
    let progress = EXPManager.expProgress / EXPManager.expThreshold // Normalize to 0-1

    return VStack(alignment: .leading) {
        //Text("SIGAI®")
        //    .font(.system(size: 40, weight: .bold, design: .rounded))

        ZStack(alignment: .leading) {
            Rectangle()
                .frame(height: 10)
                .foregroundColor(Color.gray.opacity(0.3))
                .cornerRadius(5)

            Rectangle()
                .frame(width: 200 * CGFloat(progress), height: 10) // Adjust width dynamically
                .foregroundColor(.blue)
                .cornerRadius(5)
        
            HStack {
                Text("\(Int(progress * 100))%")
                    .font(.system(size: 7, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.leading, 5)
                
                Text(appLanguage == "ms" ? "Tahap \(EXPManager.level)" :"Level \(EXPManager.level)")
                    .font(.system(size: 7, weight: .bold, design: .rounded))
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 5)
            }
        }
        .frame(width: 200, height: 10) // Fixed total width
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
