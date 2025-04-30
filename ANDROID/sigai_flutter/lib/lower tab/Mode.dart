//
//  Mode.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//


import 'package:flutter/material.dart';

class ModePage extends StatefulWidget {
  final String appLanguage;
  const ModePage({super.key, required this.appLanguage});

  @override
  State<ModePage> createState() => _ModePageState();
}

class _ModePageState extends State<ModePage> {
  bool isDarkMode = false;
  late String appLanguage;
  String mode = 'multiplication';
  Color selectedColor = Colors.grey;
  bool isLocked = false;
  List<Widget> paths = [];

  String currentTip = "";
  int currentTipIndex = 0;
  final List<String> tipsMs = [
    "Pilih warna ikut kod: 🟣 -100, 🟡 -10, ⚫ 0, 🟢 1, 🔵 10, 🔴 100",
    "Untuk darab, kunci tidak digunakan.",
    "Untuk bahagi, lukis garis menegak, kunci, kemudian lukis garisan melintang.",
    "Tekan 'Hantar' untuk semak jawapan!",
    "Tekan 'Seterusnya' untuk skip ke soalan seterusnya"
  ];
  final List<String> tipsEn = [
    "Pick colors based on code: 🟣 -100, 🟡 -10, ⚫ 0, 🟢 1, 🔵 10, 🔴 100",
    "For multiplication, lock is not used.",
    "For division, draw vertical lines, lock, then draw horizontal lines.",
    "Press 'Submit' to check the answer!",
    "Press 'Next' to skip to the next question"
  ];

  @override
  void initState() {
    super.initState();
    appLanguage = widget.appLanguage;
    currentTip = appLanguage == 'ms' ? tipsMs[0] : tipsEn[0];
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = isDarkMode || Theme.of(context).brightness == Brightness.dark;
    final gradientColors = dark
        ? [Colors.black, Colors.white, Colors.grey, Colors.white, Colors.grey[200]!]
        : [
            const Color(0xFFEBFAFF),
            Colors.white,
            const Color(0xFFDCEFFF),
            Colors.white,
            const Color(0xFFFFDCE6),
          ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(dark),
              const SizedBox(height: 16),
              _buildTopControls(),
              const SizedBox(height: 16),
              Expanded(child: _buildCanvasPlaceholder()),
              _buildBottomButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool dark) {
    String question = mode == 'multiplication' ? "12 x 3" : "36 ÷ 3";
    String result = mode == 'multiplication' ? "36" : "12.000000";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: dark
                ? [const Color(0xFF323264), const Color(0xFF505096)]
                : [const Color(0xFFFFCCE5), const Color(0xFFD2F0FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              mode == 'multiplication'
                  ? (appLanguage == 'ms' ? "Hasil Darab: $question" : "Multiplication Result: $question")
                  : (appLanguage == 'ms' ? "Hasil Bahagi: $question" : "Division Result: $question"),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: dark ? Colors.yellow.shade200 : Colors.blue.shade300,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              result,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: dark ? Colors.yellow.shade200 : Colors.blue.shade300,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              appLanguage == "ms" ? "Lukis jawapan." : "Draw your answer.",
              style: TextStyle(
                fontSize: 16,
                color: dark ? Colors.white70 : Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Wrap(
        spacing: 20,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.tips_and_updates, size: 32, color: Colors.orange),
            onPressed: () {
              List<String> tips = appLanguage == 'ms' ? tipsMs : tipsEn;
              setState(() {
                currentTipIndex = (currentTipIndex + 1) % tips.length;
                currentTip = tips[currentTipIndex];
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(currentTip)));
            },
          ),
          IconButton(
            icon: const Icon(Icons.undo, size: 32, color: Colors.grey),
            onPressed: () {
              if (paths.isNotEmpty) {
                setState(() {
                  paths.removeLast();
                });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.palette, size: 32, color: selectedColor),
            onPressed: () {
              setState(() {
                selectedColor = selectedColor == Colors.red ? Colors.green : Colors.red;
              });
            },
          ),
          IconButton(
            icon: Icon(mode == 'multiplication' ? Icons.close : Icons.calculate, size: 32, color: Colors.grey),
            onPressed: () {
              setState(() {
                mode = mode == 'multiplication' ? 'division' : 'multiplication';
              });
            },
          ),
          IconButton(
            icon: Icon(isLocked ? Icons.lock : Icons.lock_open, size: 32, color: Colors.grey),
            onPressed: () {
              setState(() {
                isLocked = !isLocked;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever, size: 32, color: Colors.grey),
            onPressed: () {
              setState(() {
                paths.clear();
                isLocked = false;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCanvasPlaceholder() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.4),
      ),
      child: const Center(child: Text("Canvas Placeholder")),
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.send),
            label: Text(appLanguage == 'ms' ? 'Hantar' : 'Submit'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.navigate_next),
            label: Text(appLanguage == 'ms' ? 'Seterusnya' : 'Next'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            ),
          ),
        ],
      ),
    );
  }
}
