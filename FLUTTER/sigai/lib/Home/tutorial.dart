
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorialView extends StatefulWidget {
  const TutorialView({super.key});

  @override
  State<TutorialView> createState() => _TutorialViewState();
}

class _TutorialViewState extends State<TutorialView> {
  String appLanguage = 'ms';

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      appLanguage = prefs.getString('appLanguage') ?? 'ms';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMalay = appLanguage == 'ms';

    return Scaffold(
      appBar: AppBar(title: Text(isMalay ? 'Panduan Awal' : 'Getting Started')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(isMalay ? _tutorialMs : _tutorialEn),
          const SizedBox(height: 24),
          
        ],
      ),
    );
  }

}

const String _tutorialMs = '''
1. Pilih tab "Darab" atau "Bahagi" untuk memilih operasi matematik yang ingin digunakan atau pilih "Mod berpandu" bagi penguna baru
2. Gunakan warna yang sesuai untuk melukis garisan menegak dan melintang.
3. Gunakan butang "Undo" untuk membatalkan langkah terakhir atau "Padam" untuk memulakan semula.
4. Keputusan akan dipaparkan secara automatik dalam kotak hasil darab atau bahagi.
5. Simbol dan fungsinya dijelaskan di bawah.
6. Warna dalam mod melukis mempunyai makna khusus, dijelaskan di bawah.

📌 Mod Berpandu: Membantu pengguna memahami konsep secara interaktif.
📌 Tahap & Cara Naik Level: Lengkapkan latihan untuk EXP dan naik tahap.
📌 Warna Terkunci & Tahap Unlock:
  - 🔵 Biru (10): Tahap 10
  - 🔴 Merah (100): Tahap 20
  - 🟡 Kuning (-10): Tahap 30
  - 🟣 Ungu (-100): Tahap 40
📌 Kesukaran Soalan Mengikut Tahap:
  - Tahap 1-9 → 1 digit (2-9)
  - Tahap 10-19 → 1-2 digit (2-99)
  - Tahap 20+ → 1-3 digit (2-999)
📌 Tab Darab: Melukis garisan untuk operasi darab secara visual.
📌 Tab Bahagi: Lukisan garis untuk operasi bahagi.
📌 Bar Kemajuan: Tunjuk EXP & naik level.

Simbol dan Fungsi:
- ↩ Undo
- 🎨 Warna Garisan
- ➗ Mod Bahagi
- 🔒 Kunci Garisan
- 🧽 Padam

Kod Warna:
🔴 100 (ratus), 🔵 10 (puluh), 🟢 1 (satuan), ⚪ 0 (kosong), 🟡 -10, 🟣 -100
''';

const String _tutorialEn = '''
1. Select the "Multiply" or "Divide" tab to choose the math operation or select "Guided Mode" for new user
2. Use the appropriate colors to draw vertical and horizontal lines.
3. Use the "Undo" button to cancel the last step or "Clear" to start over.
4. The result will be automatically displayed in the multiplication or division box.
5. The symbols and their functions are explained below.
6. The colors used in drawing mode have specific meanings.

📌 Guided Mode: Helps users understand concepts interactively.
📌 Leveling Up: Complete exercises for EXP and level up.
📌 Locked Colors & Unlocking Levels:
  - 🔵 Blue (10): Level 10
  - 🔴 Red (100): Level 20
  - 🟡 Yellow (-10): Level 30
  - 🟣 Purple (-100): Level 40
📌 Increasing Difficulty:
  - Level 1-9 → 1 digit (2-9)
  - Level 10-19 → 1-2 digit (2-99)
  - Level 20+ → 1-3 digit (2-999)
📌 Multiply Tab: Draw lines to multiply visually.
📌 Divide Tab: Draw vertical/horizontal lines for division.
📌 Progress Bar: Shows EXP and level-up progress.

Symbols and Functions:
- ↩ Undo
- 🎨 Line Color
- ➗ Division Mode
- 🔒 Lock Line
- 🧽 Clear

Color Code:
🔴 100 (hundreds), 🔵 10 (tens), 🟢 1 (ones), ⚪ 0 (zero), 🟡 -10, 🟣 -100
''';
