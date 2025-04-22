//
//  splashScreen.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//

import SwiftUI

extension ContentView {
    struct SplashScreenView: View {
        var body: some View {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all) // Background color
                VStack {
                    Image("Sigai-removebg-preview-2") // Ensure you have "sigai_logo" in Assets.xcassets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 500)
                    
                }
            }
        }
    }
}
