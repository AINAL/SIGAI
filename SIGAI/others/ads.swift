//
//  ads.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//

import SwiftUI

extension ContentView {
    struct BannerAdView: View {
        var body: some View {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.yellow.opacity(0.6))
                .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                .overlay(
                    Text("Dummy Ad Banner")
                        .font(.caption)
                        .foregroundColor(.black)
                )
                .shadow(radius: 2)
                .padding()
        }
    }
}
