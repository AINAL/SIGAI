//
//  Darab.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//

import SwiftUI

extension ContentView {
    // Header Section (Title & Color Picker)
    func headerSection() -> some View {
        VStack(spacing: 10) {
            
            Text(appLanguage == "ms" ? "Darab" : "Multiplication")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.top, 215)

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
                } label: {
                Image(systemName: "paintpalette.fill")
                    .font(.system(size: 32))
                    .foregroundColor(
                        selectedColor == .red ? Color.red :
                        selectedColor == .blue ? Color.blue :
                        selectedColor == .green ? Color.green :
                        Color.gray
                    )
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

    func darabTabView(geometry: GeometryProxy) -> some View {
        VStack {
            VStack {
                headerSection()

                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity)
                            .padding(5)

                        VStack {
                            Text(appLanguage == "ms" ? "Hasil Darab:" : "Multiplication Result:")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)

                            Text("\(countIntersections())")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(5)
                                .background(Color.clear)
                                .cornerRadius(5)
                                .frame(width: 200, height: 40)
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

            ZStack {
                drawingCanvas(geometry: geometry)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                if showCorrectOverlay {
                    Text(appLanguage == "ms" ? "Betul!" : "Correct!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .transition(.opacity)
                        .zIndex(2)
                }
            }
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
