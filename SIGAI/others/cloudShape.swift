//
//  cloudShape.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 27/04/2025.
//

import SwiftUI

struct CloudShapeB: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Left most
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.2, y: rect.midY + 10), radius: rect.height * 0.53, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.3, y: rect.midY), radius: rect.height * 0.65, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.4, y: rect.midY - 5), radius: rect.height * 0.55, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.5, y: rect.midY + 10), radius: rect.height * 0.65, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.6, y: rect.midY), radius: rect.height * 0.7, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.9, y: rect.midY + 10), radius: rect.height * 0.65, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY - 5), radius: rect.height * 0.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.5, y: rect.midY + 10), radius: rect.height * 0.6, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.2, y: rect.midY), radius: rect.height * 0.45, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.8, y: rect.midY - 5), radius: rect.height * 0.55, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.5, y: rect.midY + 10), radius: rect.height * 0.5, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        // Bottom fill
        path.addRect(CGRect(x: 0, y: rect.midY, width: rect.width, height: rect.height * 0.5))

        return path
    }
}

struct CloudShapeM: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Left most
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.9, y: rect.midY + 10), radius: rect.height * 0.35, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.2, y: rect.midY), radius: rect.height * 0.4, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.1, y: rect.midY - 5), radius: rect.height * 0.4, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.5, y: rect.midY + 10), radius: rect.height * 0.45, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.8, y: rect.midY), radius: rect.height * 0.43, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.6, y: rect.midY + 10), radius: rect.height * 0.31, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY - 5), radius: rect.height * 0.20, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.1, y: rect.midY + 10), radius: rect.height * 0.4, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.1, y: rect.midY), radius: rect.height * 0.42, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.9, y: rect.midY - 5), radius: rect.height * 0.45, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.4, y: rect.midY + 10), radius: rect.height * 0.48, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        // Bottom fill
        path.addRect(CGRect(x: 0, y: rect.midY, width: rect.width, height: rect.height * 0.5))

        return path
    }
}

struct CloudShapeF: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Left most
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.6, y: rect.midY + 10), radius: rect.height * 0.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.5, y: rect.midY), radius: rect.height * 0.35, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.4, y: rect.midY - 5), radius: rect.height * 0.35, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.3, y: rect.midY + 10), radius: rect.height * 0.25, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.2, y: rect.midY), radius: rect.height * 0.35, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.1, y: rect.midY + 10), radius: rect.height * 0.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY - 5), radius: rect.height * 0.25, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.1, y: rect.midY + 10), radius: rect.height * 0.3, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.2, y: rect.midY), radius: rect.height * 0.25, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.3, y: rect.midY - 5), radius: rect.height * 0.35, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.4, y: rect.midY + 10), radius: rect.height * 0.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        // Bottom fill
        path.addRect(CGRect(x: 0, y: rect.midY, width: rect.width, height: rect.height * 0.7))

        return path
    }
}

struct WaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height * 0.8))
        path.addCurve(
            to: CGPoint(x: rect.width, y: rect.height * 0.8),
            control1: CGPoint(x: rect.width * 0.3, y: rect.height),
            control2: CGPoint(x: rect.width * 0.7, y: rect.height * 0.6)
        )
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}
