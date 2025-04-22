//
//  tutorial.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//

import SwiftUI

struct TutorialView: View {
    @AppStorage("appLanguage") private var appLanguage: String = "ms" // Default language is Malay

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {

                // Fancy Font for Title
                Text(appLanguage == "ms" ? "**Panduan Awal**" : "**Getting Started**")
                    .foregroundColor(.black)
                    .font(.title2) // Fancy Font
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                if appLanguage == "ms" {
                    // Malay Version
                    Text("1. Pilih tab \"Darab\" atau \"Bahagi\" untuk memilih operasi matematik yang ingin digunakan atau pilih \"Mod berpandu\" bagi penguna baru")
                    Text("2. Gunakan warna yang sesuai untuk melukis garisan menegak dan melintang.")
                    Text("3. Gunakan butang \"Undo\" untuk membatalkan langkah terakhir atau \"Padam\" untuk memulakan semula.")
                    Text("4. Keputusan akan dipaparkan secara automatik dalam kotak hasil darab atau bahagi.")
                    Text("5. Simbol dan fungsinya dijelaskan di bawah.")
                    Text("6. Warna dalam mod melukis mempunyai makna khusus, dijelaskan di bawah.")

                    // New Explanations
                    Text("📌 **Tab Mod Berpandu**")
                        .font(.headline)
                        .padding(.top, 10)
                    Text("Mod Berpandu membantu pengguna memahami konsep matematik dengan cara interaktif. Anda boleh melukis garisan untuk menggambarkan pendaraban dan pembahagian secara visual.")
                        .font(.body)
                        .padding(.bottom, 5)

                    // Additional Guided Mode Information
                    Text(appLanguage == "ms" ? "📌 **Tahap & Cara Naik Level**" : "📌 **Leveling Up & How It Works**")
                        .font(.headline)
                        .padding(.top, 10)

                    Text(appLanguage == "ms" ?
                        "Setiap kali anda menyelesaikan latihan, anda memperoleh mata pengalaman (EXP). Apabila bar EXP penuh, tahap anda akan meningkat." :
                        "Every time you complete an exercise, you earn experience points (EXP). When the EXP bar is full, your level increases."
                    )
                    .font(.body)
                    .padding(.bottom, 5)

                    Text(appLanguage == "ms" ? "📌 **Warna Terkunci & Tahap Unlock**" : "📌 **Locked Colors & Unlocking Levels**")
                        .font(.headline)
                        .padding(.top, 5)
                    Text(appLanguage == "ms" ?
                        "Pada permulaan, hanya warna **kelabu (0) dan hijau (1)** boleh digunakan. Warna lain akan dibuka berdasarkan tahap berikut:" :
                        "Initially, only **gray (0) and green (1)** are available. Other colors unlock at these levels:"
                    )
                    .font(.body)

                    Text("- 🔵 \(appLanguage == "ms" ? "Biru (10): Buka pada Tahap 10" : "Blue (10): Unlocks at Level 10")")
                    Text("- 🔴 \(appLanguage == "ms" ? "Merah (100): Buka pada Tahap 20" : "Red (100): Unlocks at Level 20")")
                    Text("- 🟡 \(appLanguage == "ms" ? "Kuning (-10): Buka pada Tahap 30" : "Yellow (-10): Unlocks at Level 30")")
                    Text("- 🟣 \(appLanguage == "ms" ? "Ungu (-100): Buka pada Tahap 40" : "Purple (-100): Unlocks at Level 40")")
                        .padding(.bottom, 5)

                    Text(appLanguage == "ms" ? "📌 **Kesukaran Soalan Mengikut Tahap**" : "📌 **Increasing Question Difficulty by Level**")
                        .font(.headline)
                        .padding(.top, 5)

                    Text(appLanguage == "ms" ?
                        "Soalan akan menjadi semakin sukar apabila tahap anda meningkat:" :
                        "Questions will become more difficult as your level increases:"
                    )
                    .font(.body)

                    Text("- \(appLanguage == "ms" ? "Tahap 1-9 → Nombor satu digit sahaja (2-9)" : "Level 1-9 → Single-digit numbers only (2-9)")")
                    Text("- \(appLanguage == "ms" ? "Tahap 10-19 → Campuran nombor satu dan dua digit (2-99)" : "Level 10-19 → Mix of single & two-digit numbers (2-99)")")
                    Text("- \(appLanguage == "ms" ? "Tahap 20+ → Campuran nombor satu, dua atau tiga digit (2-999)" : "Level 20+ → Mix of single, two, or three-digit numbers (2-999)")")
                        .padding(.bottom, 10)

                    Text("📌 **Tab Darab**")
                        .font(.headline)
                    Text("Tab ini membolehkan anda melukis garisan untuk menyelesaikan operasi darab. Lukiskan garisan menegak dan melintang untuk mengira hasil darab dengan kaedah visual.")
                        .font(.body)
                        .padding(.bottom, 5)

                    Text("📌 **Tab Bahagi**")
                        .font(.headline)
                    Text("Tab Bahagi digunakan untuk operasi pembahagian. Lukiskan garisan menegak untuk mewakili bilangan pembahagi dan garisan melintang untuk bahagian yang dibahagikan.")
                        .font(.body)
                        .padding(.bottom, 5)

                    Text("📌 **Bar Kemajuan**")
                        .font(.headline)
                    Text("Bar kemajuan di atas menunjukkan tahap pengalaman (EXP) anda. Anda memperoleh EXP dengan menyelesaikan latihan, dan apabila penuh, anda akan naik ke tahap seterusnya.")
                        .font(.body)
                        .padding(.bottom, 10)
                } else {
                    // English Version
                    Text("1. Select the \"Multiply\" or \"Divide\" tab to choose the math operation or select \"Guided Mode\" for new user")
                    Text("2. Use the appropriate colors to draw vertical and horizontal lines.")
                    Text("3. Use the \"Undo\" button to cancel the last step or \"Clear\" to start over.")
                    Text("4. The result will be automatically displayed in the multiplication or division box.")
                    Text("5. The symbols and their functions are explained below.")
                    Text("6. The colors used in drawing mode have specific meanings, explained below.")

                    // New Explanations
                    Text("📌 **Guided Mode Tab**")
                        .font(.headline)
                        .padding(.top, 10)
                    Text("The Guided Mode helps users understand mathematical concepts interactively. You can draw lines to visually represent multiplication and division.")
                        .font(.body)
                        .padding(.bottom, 5)

                    // Additional Guided Mode Information
                    Text(appLanguage == "ms" ? "📌 **Tahap & Cara Naik Level**" : "📌 **Leveling Up & How It Works**")
                        .font(.headline)
                        .padding(.top, 10)

                    Text(appLanguage == "ms" ?
                        "Setiap kali anda menyelesaikan latihan, anda memperoleh mata pengalaman (EXP). Apabila bar EXP penuh, tahap anda akan meningkat." :
                        "Every time you complete an exercise, you earn experience points (EXP). When the EXP bar is full, your level increases."
                    )
                    .font(.body)
                    .padding(.bottom, 5)

                    Text(appLanguage == "ms" ? "📌 **Warna Terkunci & Tahap Unlock**" : "📌 **Locked Colors & Unlocking Levels**")
                        .font(.headline)
                    Text(appLanguage == "ms" ?
                        "Pada permulaan, hanya warna **kelabu (0) dan hijau (1)** boleh digunakan. Warna lain akan dibuka berdasarkan tahap berikut:" :
                        "Initially, only **gray (0) and green (1)** are available. Other colors unlock at these levels:"
                    )
                    .font(.body)

                    Text("- 🔵 \(appLanguage == "ms" ? "Biru (10): Buka pada Tahap 10" : "Blue (10): Unlocks at Level 10")")
                    Text("- 🔴 \(appLanguage == "ms" ? "Merah (100): Buka pada Tahap 20" : "Red (100): Unlocks at Level 20")")
                    Text("- 🟡 \(appLanguage == "ms" ? "Kuning (-10): Buka pada Tahap 30" : "Yellow (-10): Unlocks at Level 30")")
                    Text("- 🟣 \(appLanguage == "ms" ? "Ungu (-100): Buka pada Tahap 40" : "Purple (-100): Unlocks at Level 40")")
                        .padding(.bottom, 5)

                    Text(appLanguage == "ms" ? "📌 **Kesukaran Soalan Mengikut Tahap**" : "📌 **Increasing Question Difficulty by Level**")
                        .font(.headline)

                    Text(appLanguage == "ms" ?
                        "Soalan akan menjadi semakin sukar apabila tahap anda meningkat:" :
                        "Questions will become more difficult as your level increases:"
                    )
                    .font(.body)

                    Text("- \(appLanguage == "ms" ? "Tahap 1-9 → Nombor satu digit sahaja (2-9)" : "Level 1-9 → Single-digit numbers only (2-9)")")
                    Text("- \(appLanguage == "ms" ? "Tahap 10-19 → Campuran nombor satu dan dua digit (2-99)" : "Level 10-19 → Mix of single & two-digit numbers (2-99)")")
                    Text("- \(appLanguage == "ms" ? "Tahap 20+ → Campuran nombor satu, dua atau tiga digit (2-999)" : "Level 20+ → Mix of single, two, or three-digit numbers (2-999)")")
                        .padding(.bottom, 10)

                    Text("📌 **Tab Darab**")
                        .font(.headline)
                    Text("This tab allows you to draw lines to perform multiplication operations. Draw vertical and horizontal lines to calculate the result visually.")
                        .font(.body)
                        .padding(.bottom, 5)

                    Text("📌 **Tab Bahagi**")
                        .font(.headline)
                    Text("The Divide Tab is used for division operations. Draw vertical lines to represent the divisor and horizontal lines for the divided sections.")
                        .font(.body)
                        .padding(.bottom, 5)

                    Text("📌 **Progress Bar**")
                        .font(.headline)
                    Text("The progress bar at the top shows your experience (EXP) level. You gain EXP by completing exercises, and when it’s full, you level up to the next stage.")
                        .font(.body)
                        .padding(.bottom, 10)
                }

                // Symbol Explanation Section
                VStack(alignment: .leading, spacing: 8) {
                    Text(appLanguage == "ms" ? "Simbol dan Fungsi" : "Symbols and Functions")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 10)

                    HStack {
                        Image(systemName: "arrow.uturn.backward.circle.fill")
                            .font(.title)
                        Text(appLanguage == "ms" ? "Undo: Membatalkan langkah terakhir" : "Undo: Cancels the last step")
                    }

                    HStack {
                        Image(systemName: "paintpalette.fill")
                            .font(.title)
                        Text(appLanguage == "ms" ? "Warna Garisan: Pilih warna untuk garisan" : "Line Color: Select a color for lines")
                    }

                    HStack {
                        Image(systemName: "divide.circle.fill")
                            .font(.title)
                        Text(appLanguage == "ms" ? "Mod Bahagi: Tukar ke operasi bahagi" : "Division Mode: Switch to division operation")
                    }

                    HStack {
                        Image(systemName: "lock.fill")
                            .font(.title)
                        Text(appLanguage == "ms" ? "Kunci Garisan: Mengunci garisan dari perubahan" : "Lock Line: Locks the lines from changes")
                    }

                    HStack {
                        Image(systemName: "eraser.fill")
                            .font(.title)
                        Text(appLanguage == "ms" ? "Padam: Kosongkan lukisan" : "Clear: Erase all drawings")
                    }
                }
                .padding(.top, 10)

                // Color Code Explanation Section
                VStack(alignment: .leading, spacing: 8) {
                    Text(appLanguage == "ms" ? "Kod Warna dalam Melukis" : "Color Code in Drawing")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 10)

                    HStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 30, height: 30)
                        Text(appLanguage == "ms" ? "100: Melambangkan nilai ratusan" : "100: Represents hundreds")
                    }

                    HStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 30, height: 30)
                        Text(appLanguage == "ms" ? "10: Melambangkan nilai puluhan" : "10: Represents tens")
                    }

                    HStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 30, height: 30)
                        Text(appLanguage == "ms" ? "1: Melambangkan nilai satuan" : "1: Represents ones")
                    }
                    
                    HStack {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 30, height: 30)
                        Text(appLanguage == "ms" ? "0: Melambangkan nilai kosongan" : "0: Represents zeros")
                    }

                    HStack {
                        Circle()
                            .fill(Color.yellow)
                            .frame(width: 30, height: 30)
                        Text(appLanguage == "ms" ? "-10: Melambangkan nilai negatif sepuluh" : "-10: Represents negative ten")
                    }

                    HStack {
                        Circle()
                            .fill(Color.purple)
                            .frame(width: 30, height: 30)
                        Text(appLanguage == "ms" ? "-100: Melambangkan nilai negatif seratus" : "-100: Represents negative hundred")
                    }
                }
                .padding(.top, 10)

                // Example Images (Remains the Same)
                VStack {
                    Text(appLanguage == "ms" ? "Contoh" : "Example")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    Image("IMG_1726").resizable().scaledToFit().frame(width: 300, height: 400).cornerRadius(10).shadow(radius: 5).padding()
                    Text(appLanguage == "ms" ? "Darab 2 x 2:" : "Multiply 2 x 2:")
                        .font(.body)
                        .fontWeight(.semibold)
                        .padding(.bottom, 10)
                }

                VStack {
                    Image("IMG_1727").resizable().scaledToFit().frame(width: 300, height: 400).cornerRadius(10).shadow(radius: 5).padding()
                    Text(appLanguage == "ms" ? "Darab 21 x 2:" : "Multiply 21 x 2:")
                        .font(.body)
                        .fontWeight(.semibold)
                        .padding(.bottom, 10)
                }
                
                VStack {
                    Image("IMG_1728").resizable().scaledToFit().frame(width: 300, height: 400).cornerRadius(10).shadow(radius: 5).padding()
                    Text(appLanguage == "ms" ? "Darab 202 x 112:" : "Multiply 202 x 112:")
                        .font(.body)
                        .fontWeight(.semibold)
                        .padding(.bottom, 10)
                }
                
                VStack {
                    Image("IMG_1729").resizable().scaledToFit().frame(width: 300, height: 400).cornerRadius(10).shadow(radius: 5).padding()
                    Text(appLanguage == "ms" ? "Bahagi 4 / 2:" : "Divide 4 / 2:")
                        .font(.body)
                        .fontWeight(.semibold)
                        .padding(.bottom, 10)
                }
                
                VStack {
                    Image("IMG_1730").resizable().scaledToFit().frame(width: 300, height: 400).cornerRadius(10).shadow(radius: 5).padding()
                    Text(appLanguage == "ms" ? "Bahagi 15 / 3:" : "Divide 15 / 3:")
                        .font(.body)
                        .fontWeight(.semibold)
                        .padding(.bottom, 10)
                }
                
                VStack {
                    Image("IMG_1731").resizable().scaledToFit().frame(width: 300, height: 400).cornerRadius(10).shadow(radius: 5).padding()
                    Text(appLanguage == "ms" ? "Bahagi 144 / 12:" : "Divide 144 / 12:")
                        .font(.body)
                        .fontWeight(.semibold)
                        .padding(.bottom, 10)
                }
                
                VStack {
                    Image("IMG_1732").resizable().scaledToFit().frame(width: 300, height: 400).cornerRadius(10).shadow(radius: 5).padding()
                    Text(appLanguage == "ms" ? "Bahagi 211 / 111:" : "Divide 211 / 111:")
                        .font(.body)
                        .fontWeight(.semibold)
                        .padding(.bottom, 10)
                }
                
            }
            .padding()
            .background(Color.white)
        }
        .background(Color.white)
        .navigationTitle("Tutorial")
    }
}
