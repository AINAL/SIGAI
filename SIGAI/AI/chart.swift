//
//  chart.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 18/05/2025.
//
import SwiftUI

struct LineIntersectionView: View {
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
        ScrollView([.horizontal, .vertical], showsIndicators: false) {
            ZStack {
                // Draw vertical lines
                ForEach(0..<x, id: \.self) { i in
                    Path { path in
                        let xPos = spacing * CGFloat(i + 1)
                        path.move(to: CGPoint(x: xPos, y: spacing))
                        path.addLine(to: CGPoint(x: xPos, y: spacing * CGFloat(y)))
                    }
                    .stroke(verticalLineColor, lineWidth: 2)
                }

                // Draw horizontal lines
                ForEach(0..<y, id: \.self) { j in
                    Path { path in
                        let yPos = spacing * CGFloat(j + 1)
                        path.move(to: CGPoint(x: spacing, y: yPos))
                        path.addLine(to: CGPoint(x: spacing * CGFloat(x), y: yPos))
                    }
                    .stroke(horizontalLineColor, lineWidth: 2)
                }

                // Draw intersection points
                ForEach(0..<x, id: \.self) { i in
                    ForEach(0..<y, id: \.self) { j in
                        let xPos = spacing * CGFloat(i + 1)
                        let yPos = spacing * CGFloat(j + 1)
                        Circle()
                            .fill(Color.purple)
                            .frame(width: 8, height: 8)
                            .position(x: xPos, y: yPos)
                    }
                }
            }
            .frame(width: spacing * CGFloat(x + 1), height: spacing * CGFloat(y + 1))
        }
        .frame(width: 280, height: 280)
        .padding(.horizontal, 8)
    }
}
