//
//  calculate.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//

import SwiftUI

extension ContentView {// Function to count intersections based on color
    func countIntersections() -> Int {
        var total = 0
        let pathCount = paths.count
        
        for i in 0..<pathCount {
            for j in (i + 1)..<pathCount {
                if pathsIntersect(paths[i], paths[j]) {
                    // Determine color-based intersection value
                    if (colors[i] == .red && colors[j] == .green) || (colors[i] == .green && colors[j] == .red) {
                        total += 100 // Red × Green = 100
                    } else if (colors[i] == .red && colors[j] == .blue) || (colors[i] == .blue && colors[j] == .red) {
                        total += 1000 // Red × Blue = 1000
                    } else if colors[i] == .green && colors[j] == .green {
                        total += 1 // Green × Green = 1
                    } else if colors[i] == .blue && colors[j] == .blue {
                        total += 100 // Blue × Blue = 100
                    } else if colors[i] == .red && colors[j] == .red {
                        total += 10000 // Red × Red = 10000
                    } else if colors[i] == .blue && colors[j] == .green || colors[i] == .green && colors[j] == .blue {
                        total += 10 // Blue × Green = 10 (Fix applied)
                    }
                }
            }
        }
        
        return total
    }
    
    // Function to count divisions based on color
    func countDivisions() -> Double {
        let pathCount = paths.count
        
        let totalVerticalLines: Int
        if let lockedValue = lockedVerticalLines {
            totalVerticalLines = lockedValue // Use locked value if set
        } else {
            totalVerticalLines = paths.filter { path in
                let points = extractPoints(from: path)
                guard let first = points.first, let last = points.last else { return false }
                return abs(first.x - last.x) < 30.0 // Loosen threshold for vertical detection
            }.count
            
            DispatchQueue.main.async {
                self.detectedVerticalLines = totalVerticalLines
            }
        }
        
        var divisionSum: Double = 0.0
        for i in 0..<totalVerticalLines {
            for j in 0..<pathCount {
                if i < colors.count, j < colors.count, pathsIntersect(paths[i], paths[j]) {
                    let factor = getColorMultiplier(colors[i], colors[j])
                    divisionSum += factor / Double(totalVerticalLines)
                }
            }
        }
        
        return divisionSum
    }
    
    func getColorMultiplier(_ color1: Color, _ color2: Color) -> Double {
        let red = Color.red
        let blue = Color.blue
        let green = Color.green
        let yellow = Color.yellow
        let purple = Color.purple
        
        let colorMultipliers: [Color: [Color: Double]] = [
            red:    [red: 1.0, blue: 0.1, green: 0.01, yellow: 0.001, purple: 0.0001],
            blue:   [red: 10, blue: 1.0, green: 0.1, yellow: 0.01, purple: 0.001],
            green:  [red: 100, blue: 10, green: 1.0, yellow: 0.1, purple: 0.01],
            yellow: [red: 1000, blue: 100, green: 10, yellow: 1.0, purple: 0.1],
            purple: [red: 10000, blue: 1000, green: 100, yellow: 10, purple: 1.0]
        ]
        
        return colorMultipliers[color1]?[color2] ?? 1.0
    }
    
    // Improved function to check if two paths intersect
    func pathsIntersect(_ path1: Path, _ path2: Path) -> Bool {
        let points1 = extractPoints(from: path1)
        let points2 = extractPoints(from: path2)
        
        guard points1.count > 1, points2.count > 1 else { return false }
        
        for i in 0..<(points1.count - 1) {
            for j in 0..<(points2.count - 1) {
                if checkLineIntersection(points1[i], points1[i+1], points2[j], points2[j+1]) {
                    return true
                }
            }
        }
        return false
    }
    
    // Extract points from a path
    func extractPoints(from path: Path) -> [CGPoint] {
        var points: [CGPoint] = []
        path.forEach { element in
            switch element {
            case .move(to: let point), .line(to: let point):
                points.append(point)
            default:
                break
            }
        }
        return points
    }
    
    func isVerticalLine(_ path: Path, newPoint: CGPoint?) -> Bool {
        var points = extractPoints(from: path)
        if let newPoint = newPoint {
            points.append(newPoint)
        }
        guard let first = points.first, let last = points.last else { return false }
        return abs(first.x - last.x) < 5.0 // Consider it vertical if X coordinates are close
    }
    
    // Check if two line segments intersect
    func checkLineIntersection(_ p1: CGPoint, _ p2: CGPoint, _ q1: CGPoint, _ q2: CGPoint) -> Bool {
        func cross(_ v1: CGPoint, _ v2: CGPoint) -> CGFloat {
            return v1.x * v2.y - v1.y * v2.x
        }
        
        let v1 = CGPoint(x: p2.x - p1.x, y: p2.y - p1.y)
        let v2 = CGPoint(x: q2.x - q1.x, y: q2.y - q1.y)
        let v3 = CGPoint(x: q1.x - p1.x, y: q1.y - p1.y)
        let v4 = CGPoint(x: q2.x - p1.x, y: q2.y - p1.y)
        
        let cross1 = cross(v1, v3)
        let cross2 = cross(v1, v4)
        let cross3 = cross(v2, CGPoint(x: p1.x - q1.x, y: p1.y - q1.y))
        let cross4 = cross(v2, CGPoint(x: p2.x - q1.x, y: p2.y - q1.y))
        
        return (cross1 * cross2 < 0) && (cross3 * cross4 < 0)
    }
}

