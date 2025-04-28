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
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.2, y: rect.midY + 5), radius: rect.height * 0.424, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.3, y: rect.midY - 5), radius: rect.height * 0.52, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.4, y: rect.midY - 10), radius: rect.height * 0.44, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.5, y: rect.midY + 5), radius: rect.height * 0.52, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.6, y: rect.midY - 5), radius: rect.height * 0.56, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.9, y: rect.midY + 5), radius: rect.height * 0.52, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY - 10), radius: rect.height * 0.16, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.5, y: rect.midY + 5), radius: rect.height * 0.48, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.2, y: rect.midY - 5), radius: rect.height * 0.36, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.8, y: rect.midY - 10), radius: rect.height * 0.44, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.5, y: rect.midY + 5), radius: rect.height * 0.4, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

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

struct StarScatterShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let numberOfStars = 30 // Berapa banyak bintang kau nak tabur
        let minSize: CGFloat = 2
        let maxSize: CGFloat = 8

        for _ in 0..<numberOfStars {
            let randomX = CGFloat.random(in: 0...rect.width)
            let randomY = CGFloat.random(in: 0...(rect.height * 0.6)) // only atas sikit
            let size = CGFloat.random(in: minSize...maxSize)

            path.addEllipse(in: CGRect(x: randomX, y: randomY, width: size, height: size))
        }

        return path
    }
}


struct CloudShapeBLong: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Left most, fuller and rounder cloud with more overlapping arcs and larger radii
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.10, y: rect.midY + 14), radius: rect.height * 0.53 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.15, y: rect.midY + 10), radius: rect.height * 0.45 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.20, y: rect.midY + 7), radius: rect.height * 0.53 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.25, y: rect.midY + 5), radius: rect.height * 0.45 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.30, y: rect.midY + 2), radius: rect.height * 0.65 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.35, y: rect.midY - 2), radius: rect.height * 0.55 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.40, y: rect.midY - 6), radius: rect.height * 0.55 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.45, y: rect.midY - 10), radius: rect.height * 0.65 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.55, y: rect.midY + 4), radius: rect.height * 0.65 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.60, y: rect.midY), radius: rect.height * 0.7 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.75, y: rect.midY + 8), radius: rect.height * 0.65 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.90, y: rect.midY + 10), radius: rect.height * 0.65 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        // Center
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY - 8), radius: rect.height * 0.20 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        // Right side, mirror left bumps, overlap more
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.10, y: rect.midY + 12), radius: rect.height * 0.53 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.15, y: rect.midY + 8), radius: rect.height * 0.45 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.20, y: rect.midY + 5), radius: rect.height * 0.45 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.25, y: rect.midY + 2), radius: rect.height * 0.35 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.30, y: rect.midY), radius: rect.height * 0.45 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.40, y: rect.midY - 2), radius: rect.height * 0.55 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.45, y: rect.midY - 5), radius: rect.height * 0.60 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.55, y: rect.midY + 7), radius: rect.height * 0.5 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.65, y: rect.midY + 10), radius: rect.height * 0.6 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.80, y: rect.midY - 2), radius: rect.height * 0.55 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        // Bottom fill
        path.addRect(CGRect(x: 0, y: rect.midY, width: rect.width, height: rect.height * 0.5))

        return path
    }
}

struct CloudShapeMLong: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Left most, fuller and rounder with more bumps and larger radii
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.95, y: rect.midY + 12), radius: rect.height * 0.35 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.85, y: rect.midY + 10), radius: rect.height * 0.38 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.75, y: rect.midY + 6), radius: rect.height * 0.43 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.65, y: rect.midY + 10), radius: rect.height * 0.31 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.55, y: rect.midY + 8), radius: rect.height * 0.45 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.40, y: rect.midY + 4), radius: rect.height * 0.40 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.30, y: rect.midY + 2), radius: rect.height * 0.40 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.20, y: rect.midY), radius: rect.height * 0.40 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.10, y: rect.midY - 3), radius: rect.height * 0.40 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        // Center
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY - 6), radius: rect.height * 0.20 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        // Right side, mirror left bumps, overlap more
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.10, y: rect.midY + 6), radius: rect.height * 0.40 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.15, y: rect.midY + 10), radius: rect.height * 0.40 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.22, y: rect.midY + 4), radius: rect.height * 0.42 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.35, y: rect.midY + 7), radius: rect.height * 0.48 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.45, y: rect.midY + 10), radius: rect.height * 0.48 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.70, y: rect.midY + 8), radius: rect.height * 0.45 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.90, y: rect.midY - 3), radius: rect.height * 0.45 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        // Bottom fill
        path.addRect(CGRect(x: 0, y: rect.midY, width: rect.width, height: rect.height * 0.5))

        return path
    }
}

struct CloudShapeFLong: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Left most, fuller and rounder with more bumps and larger radii
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.65, y: rect.midY + 12), radius: rect.height * 0.20 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        // Extra arc between -0.65 and -0.55
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.60, y: rect.midY + 10), radius: rect.height * 0.27 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.55, y: rect.midY + 8), radius: rect.height * 0.28 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        // Extra arc between -0.55 and -0.50
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.525, y: rect.midY + 5), radius: rect.height * 0.29 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.50, y: rect.midY + 2), radius: rect.height * 0.35 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.47, y: rect.midY), radius: rect.height * 0.31 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.45, y: rect.midY - 2), radius: rect.height * 0.35 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        // Extra arc between -0.45 and -0.40
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.425, y: rect.midY - 3), radius: rect.height * 0.33 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.40, y: rect.midY - 5), radius: rect.height * 0.35 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        // Center left extra arc
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.37, y: rect.midY + 3), radius: rect.height * 0.27 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.35, y: rect.midY + 7), radius: rect.height * 0.25 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        // Extra arc between -0.35 and -0.30
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.325, y: rect.midY + 5), radius: rect.height * 0.28 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.30, y: rect.midY + 2), radius: rect.height * 0.25 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        // Center extra arc
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.10, y: rect.midY + 8), radius: rect.height * 0.20 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.20, y: rect.midY), radius: rect.height * 0.35 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        // Center
        // Extra arc just left of center
        path.addArc(center: CGPoint(x: rect.midX - rect.width * 0.05, y: rect.midY - 2), radius: rect.height * 0.28 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY - 4), radius: rect.height * 0.25 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        // Extra arc just right of center
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.05, y: rect.midY - 2), radius: rect.height * 0.28 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        // Right side, mirror left bumps, overlap more
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.10, y: rect.midY + 10), radius: rect.height * 0.30 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        // Extra arc between 0.10 and 0.18
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.14, y: rect.midY + 6), radius: rect.height * 0.28 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.18, y: rect.midY + 2), radius: rect.height * 0.25 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        // Extra arc between 0.18 and 0.25
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.215, y: rect.midY), radius: rect.height * 0.28 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.25, y: rect.midY - 2), radius: rect.height * 0.25 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        // Extra arc between 0.25 and 0.30
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.275, y: rect.midY - 3), radius: rect.height * 0.28 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.30, y: rect.midY - 5), radius: rect.height * 0.35 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        // Center right extra arc
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.33, y: rect.midY + 2), radius: rect.height * 0.25 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.35, y: rect.midY + 7), radius: rect.height * 0.20 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        // Extra arc between 0.35 and 0.40
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.375, y: rect.midY + 8), radius: rect.height * 0.23 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX + rect.width * 0.40, y: rect.midY + 10), radius: rect.height * 0.20 * 1.2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)

        // Bottom fill
        path.addRect(CGRect(x: 0, y: rect.midY, width: rect.width, height: rect.height * 0.7))

        return path
    }
}

struct StarScatterShapeLong: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let numberOfStars = 60 // Berapa banyak bintang kau nak tabur
        let minSize: CGFloat = 2
        let maxSize: CGFloat = 8

        for _ in 0..<numberOfStars {
            let randomX = CGFloat.random(in: 0...rect.width)
            let randomY = CGFloat.random(in: 0...(rect.height * 0.6)) // only atas sikit
            let size = CGFloat.random(in: minSize...maxSize)

            path.addEllipse(in: CGRect(x: randomX, y: randomY, width: size, height: size))
        }

        return path
    }
}
