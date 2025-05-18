//
//  chartBahagi.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 18/05/2025.
//

import SwiftUI

struct ChartBahagiView: View {
    var x: Int
    var y: Int
    let baseSpacing: CGFloat = 40
    var spacing: CGFloat {
        let factor = max(x, y)
        return factor > 6 ? max(16, 240 / CGFloat(factor)) : baseSpacing
    }
    let verticalLineColor = Color.blue
    let horizontalLineColor = Color.red
    let dynamicPadding: CGFloat = 16

    var body: some View {
        let baseDots = y / max(x, 1)
        let remainder = y % max(x, 1)
        let maxDots = baseDots + (remainder > 0 ? 1 : 0)
        let totalHeight = spacing * CGFloat(maxDots + 1)

        return ScrollView([.horizontal, .vertical], showsIndicators: false) {
            ZStack {
                // Solid vertical lines
                ForEach(0..<x, id: \.self) { i in
                    Path { path in
                        let xPos = spacing * CGFloat(i + 1)
                        path.move(to: CGPoint(x: xPos, y: spacing))
                        path.addLine(to: CGPoint(x: xPos, y: totalHeight))
                    }
                    .stroke(verticalLineColor, lineWidth: 2)
                }

                // Dots placed along each vertical line
                ForEach(0..<x, id: \.self) { i in
                    let dots = baseDots + (i < remainder ? 1 : 0)
                    ForEach(0..<dots, id: \.self) { j in
                        let xPos = spacing * CGFloat(i + 1)
                        let yPos = spacing * CGFloat(maxDots - j)
                        Circle()
                            .fill(horizontalLineColor)
                            .frame(width: 8, height: 8)
                            .position(x: xPos, y: yPos)
                    }
                }
            }
            .frame(width: spacing * CGFloat(x + 1), height: spacing * CGFloat(maxDots + 1))
        }
        .frame(
            width: min(spacing * CGFloat(x + 2), 320),
            height: min(spacing * CGFloat(maxDots + 2), 320)
        )
        .padding(.horizontal, 8)
    }
}
