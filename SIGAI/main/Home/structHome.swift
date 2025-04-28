//
//  struct.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//

import SwiftUI

// Custom Section View
struct SectionView: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @Environment(\.colorScheme) var colorScheme

    let title: String
    let description: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)
                .foregroundColor((isDarkMode == true) ? .yellow : .blue)

            Text(description)
                .font(.subheadline)
                .foregroundColor((isDarkMode == true) ? .white : .black)

        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

// Custom Section Button for Navigation
struct SectionButton: View {
    let title: String
    let icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(.white)

            Text(title)
                .font(.headline)
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .cornerRadius(10)
    }
}

// Custom Button for Home Links
struct HomeTabButton: View {
    let title: String
    let icon: String

    var body: some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)

            Text(title)
                .font(.headline)
                .foregroundColor(.black)
        }
        .padding()
        .frame(width: 120, height: 120)
        .background(Color.white.opacity(0.9))
        .cornerRadius(15)
        .shadow(radius: 3)
    }
}
