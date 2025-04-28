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
            
            //Text(appLanguage == "ms" ? "Bahagi" : "Division" )
            //Text("Bahagi")
                //.font(.largeTitle)
                //.fontWeight(.bold)
                //.foregroundColor(.primary)
                //.padding(.top, 230)

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
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: isDarkMode ? [
                    Color.black,
                    Color.white,
                    Color.gray,
                    Color.white,
                    Color(red: 230/255, green: 230/255, blue: 230/255) // Light Gray
                ] : [
                    Color(red: 235/255, green: 250/255, blue: 255/255),
                    Color.white,
                    Color(red: 220/255, green: 245/255, blue: 255/255), // Very light blue
                    Color.white,
                    Color(red: 255/255, green: 220/255, blue: 230/255)  // Softer pink
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack {
                VStack {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: isDarkMode ? [
                                            Color(red: 50/255, green: 50/255, blue: 100/255), // Dark Blue
                                            Color(red: 80/255, green: 80/255, blue: 150/255)  // Slightly lighter Dark Blue
                                        ] : [
                                            Color(red: 1.0, green: 0.8, blue: 0.9), // Soft Pink
                                            Color(red: 210/255, green: 240/255, blue: 255/255) // Light Blue
                                        ]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                                .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 3)
                                .frame(maxWidth: .infinity)
                                .padding(5)

                            VStack {
                                Text(appLanguage == "ms" ? "Hasil Bahagi (\(detectedVerticalLines) garis):" : "Division Result (\(detectedVerticalLines) line/s):")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(isDarkMode ? Color.yellow.opacity(0.8) : Color.blue.opacity(0.7))
                                    .shadow(color: (isDarkMode ? Color.yellow.opacity(0.2) : Color.blue.opacity(0.2)), radius: 5, x: 0, y: 2)

                                Text(String(format: "%.6f", countDivisions()))
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(5)
                                    .background(Color.clear)
                                    .cornerRadius(5)
                                    .frame(width: 350, height: 40)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(isDarkMode ? Color.yellow.opacity(0.8) : Color.blue.opacity(0.7))
                                    .shadow(color: (isDarkMode ? Color.yellow.opacity(0.2) : Color.blue.opacity(0.2)), radius: 5, x: 0, y: 2)

                                Text(appLanguage == "ms" ? "Pilih warna dan lukis." : "Pick a color and draw.")
                                    .font(.body)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(isDarkMode ? Color.white.opacity(0.8) : .secondary)
                                    .shadow(color: isDarkMode ? Color.white.opacity(0.2) : Color.clear, radius: 5, x: 0, y: 2)
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.horizontal, 20)
                            }
                            .padding(5)
                        }
                        .padding(.horizontal)
                    }
                    headerSectionBahagi()
                        .padding(.top, 20)
                }
                .padding(.top, geometry.safeAreaInsets.top + 20)

                Spacer()

                ZStack {
                    drawingCanvas(geometry: geometry)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            paths.removeAll()
            colors.removeAll()
            currentPath = Path()
        }
        .preferredColorScheme(.light)
    }
}
