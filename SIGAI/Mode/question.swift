//
//  question.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//

import SwiftUI

extension ContentView {
    func generateQuestion() {
        let level = EXPManager.level

        // Determine number range based on level
        let range: ClosedRange<Int>
        if level >= 20 {
            range = 2...999 // Single, two, or three-digit numbers
        } else if level >= 10 {
            range = 2...99  // Single or two-digit numbers
        } else {
            range = 2...9   // Only single-digit numbers
        }

        let num1 = Int.random(in: range)
        let num2 = Int.random(in: range)

        if mode == .multiplication {
            question = "\(num1) × \(num2) = ?"
            correctAnswer = num1 * num2
        } else {
            let product = num1 * num2 * 1/2
            question = "\(product) ÷ \(num1) = ?"
            correctAnswerB = Double(product) / Double(num1)
        }

        userAnswer = "" // Reset input
        showFeedback = false // Reset feedback
    }
}
