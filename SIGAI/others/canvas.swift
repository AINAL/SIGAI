//
//  canvas.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//

import SwiftUI

extension ContentView {
    // Drawing Canvas (Expands Dynamically)
    func drawingCanvas(geometry: GeometryProxy) -> some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if currentPath.isEmpty {
                            currentPath.move(to: value.location)
                        }
                        currentPath.addLine(to: value.location)
                    }
                    .onEnded { _ in
                        DispatchQueue.main.async {
                            paths.append(currentPath)
                            colors.append(selectedColor)
                            currentPath = Path()
                        }
                    }
            )

            // Render Drawn Paths
            ForEach(paths.indices, id: \.self) { index in
                paths[index]
                    .stroke(colors[index], lineWidth: 4)
            }

            // Render Current Drawing
            currentPath
                .stroke(selectedColor, lineWidth: 4)
        }
        .frame(width: geometry.size.width, height: geometry.size.height)
    }
}

