//
//  Bahagi.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//

import SwiftUI

extension ContentView {
    // Header Section for Bahagi Tab (Title & Color Picker)
    func headerSectionBahagi() -> some View {
        VStack(spacing: 10) {
            
            Text(appLanguage == "ms" ? "Bahagi" : "Division" )
            //Text("Bahagi")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.top, 230)

            // Dropdown for Color Selection
            HStack {
                
                Button(action: {
                    if !paths.isEmpty {
                        paths.removeLast()
                        colors.removeLast()
                    }
                }) {
                    Image(systemName: "arrow.uturn.backward.circle.fill")
                        .font(.system(size: 32))
                        //.padding()
                        //.frame(width: 100)
                        .background(Color.clear)
                        .foregroundColor(.gray)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }
                
                Menu {
                    Button(action: { selectedColor = .red }) {
                        Label("🔴 100", systemImage: "circle.fill")
                            .foregroundColor(.red)
                    }
                    Button(action: { selectedColor = .blue }) {
                        Label("🔵 10", systemImage: "circle.fill")
                            .foregroundColor(.blue)
                    }
                    Button(action: { selectedColor = .green }) {
                        Label("🟢 1", systemImage: "circle.fill")
                            .foregroundColor(.green)
                    }
                    Button(action: { selectedColor = .gray }) {
                        Label("⚫ 0", systemImage: "circle.fill")
                            .foregroundColor(.gray)
                    }
                    Button(action: { selectedColor = .yellow }) {
                        Label("🟡 -10", systemImage: "circle.fill")
                            .foregroundColor(.yellow)
                    }
                    Button(action: { selectedColor = .purple }) {
                        Label("🟣 -100", systemImage: "circle.fill")
                            .foregroundColor(.purple)
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
                if lockedVerticalLines == nil {
                    lockedVerticalLines = detectedVerticalLines
                } else {
                    lockedVerticalLines = nil
                }
                }) {
                    Image(systemName: (lockedVerticalLines != nil) ? "lock.fill" : "lock.open.fill") // Locked in multiplication mode
                        .font(.system(size: 36)) // Bigger size for visibility
                        .foregroundColor((lockedVerticalLines != nil) ? .gray : .blue) // Gray if locked, blue if unlockable
                }
                
                
                Button(action: {
                    paths.removeAll()
                    colors.removeAll()
                    currentPath = Path()
                    isLocked = false
                    lockedVerticalLines = nil // Unlock when clearing
                }) {
                    Image(systemName: "eraser.fill")
                        .font(.system(size: 32))
                        //.padding()
                        //.frame(width: 100)
                        .background(Color.clear)
                        .foregroundColor(.gray)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                }
            }
            .padding(.horizontal)
        }
    }

    
    func bahagiTabView(geometry: GeometryProxy) -> some View {
        VStack {
            VStack {
                headerSectionBahagi()
                    .padding(.bottom, 10)

                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity)
                            .padding(5)

                        VStack {
                            Text(appLanguage == "ms" ? "Hasil Bahagi (\(detectedVerticalLines) garis):" : "Division Result (\(detectedVerticalLines) line/s):")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)

                            Text(String(format: "%.6f", countDivisions()))
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(5)
                                .background(Color.clear)
                                .cornerRadius(5)
                                .frame(width: 350, height: 40)
                                .multilineTextAlignment(.center)

                            Text(appLanguage == "ms" ? "Pilih warna dan lukis." : "Pick a color and draw.")
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
            }
            .padding(.top, geometry.safeAreaInsets.top + 20)

            Spacer()

            drawingCanvas(geometry: geometry)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
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
