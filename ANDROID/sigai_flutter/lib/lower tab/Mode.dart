//
//  Mode.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//

import 'package:flutter/material.dart';
import 'package:sigai_flutter/mainfunc/calculate.dart';


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
  List<List<Offset?>> strokes = [];
  List<Color> strokeColors = [];

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
              _buildResultDisplay(),
              const SizedBox(height: 16),
              _buildTopControls(),
              const SizedBox(height: 16),
              Expanded(
                child: Column(
                  children: [
                    Expanded(child: _buildCanvasPlaceholder()),
                  ],
                ),
              ),
              _buildBottomButtons(),
            ],
          ),
        ),
      ),
    );
  }

  
  PopupMenuItem<Color> _colorOption(Color color, String label) {
    return PopupMenuItem(
      value: color,
      child: Row(
        children: [
          Icon(Icons.circle, color: color),
          const SizedBox(width: 10),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildTopControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Wrap(
        spacing: 10,
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
              if (strokes.isNotEmpty) {
                setState(() {
                  if (strokes.last.isNotEmpty) {
                    strokes.last.removeLast();
                    if (strokes.last.isEmpty) {
                      strokes.removeLast();
                      strokeColors.removeLast();
                    }
                  }
                });
              }
            },
          ),
  
          PopupMenuButton<Color>(
            icon: Icon(Icons.palette, size: 32, color: selectedColor),
            onSelected: (color) {
              setState(() {
                selectedColor = color;
              });
            },
            itemBuilder: (context) => mode == 'multiplication'
                ? [
                    _colorOption(Colors.red, "🔴 100"),
                    _colorOption(Colors.blue, "🔵 10"),
                    _colorOption(Colors.green, "🟢 1"),
                    _colorOption(Colors.grey, "⚫ 0"),
                  ]
                : [
                    _colorOption(Colors.red, "🔴 100"),
                    _colorOption(Colors.blue, "🔵 10"),
                    _colorOption(Colors.green, "🟢 1"),
                    _colorOption(Colors.grey, "⚫ 0"),
                    _colorOption(Colors.yellow, "🟡 -10"),
                    _colorOption(Colors.purple, "🟣 -100"),
                  ],
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
                strokes.clear();
                strokeColors.clear();
                isLocked = false;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCanvasPlaceholder() {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          if (strokes.isEmpty || strokes.last.contains(null)) {
            strokes.add([details.localPosition]);
            strokeColors.add(selectedColor);
          } else {
            strokes.last.add(details.localPosition);
          }
        });
      },
      onPanEnd: (details) {
        setState(() {
          if (strokes.isNotEmpty) {
            strokes.last.add(null);
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: CustomPaint(
          painter: _ModeDrawingPainter(strokes, strokeColors),
          size: Size.infinite,
        ),
      ),
    );
  }

  int getDetectedVerticalLines(List<List<Offset?>> paths) {
    int count = 0;
    for (int i = 0; i < paths.length; i++) {
      if (strokeColors[i] == Colors.grey) continue;
      final path = paths[i];
      final first = path.firstWhere((p) => p != null, orElse: () => null);
      final last = path.lastWhere((p) => p != null, orElse: () => null);
      if (first != null && last != null && (first.dx - last.dx).abs() < 30.0) {
        count++;
      }
    }
    return count;
  }

  Widget _buildResultDisplay() {
    final int garisCount = getDetectedVerticalLines(strokes);
    final result = mode == 'division'
        ? countDivisions(strokes, strokeColors)
        : countIntersections(strokes, strokeColors).toDouble();

    final bool dark = isDarkMode || Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SizedBox(
        width: double.infinity,
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
                mode == 'division'
                    ? (appLanguage == "ms"
                        ? "Hasil Bahagi (${garisCount} garis):"
                        : "Division Result (${garisCount} line/s):")
                    : (appLanguage == "ms"
                        ? "Hasil Darab:"
                        : "Multiplication Result:"),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: dark ? Colors.yellow.shade200 : Colors.blue.shade300,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                mode == 'division'
                    ? result.toStringAsFixed(6)
                    : result.toStringAsFixed(0),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
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
      ),
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

class _ModeDrawingPainter extends CustomPainter {
  final List<List<Offset?>> strokes;
  final List<Color> strokeColors;

  _ModeDrawingPainter(this.strokes, this.strokeColors);

  @override
  void paint(Canvas canvas, Size size) {
    for (int s = 0; s < strokes.length; s++) {
      final paint = Paint()
        ..color = strokeColors[s]
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 5.0;

      final points = strokes[s];
      for (int i = 0; i < points.length - 1; i++) {
        if (points[i] != null && points[i + 1] != null) {
          canvas.drawLine(points[i]!, points[i + 1]!, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
