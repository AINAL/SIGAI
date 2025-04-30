import 'package:flutter/material.dart';

class BahagiPage extends StatefulWidget {
  const BahagiPage({super.key});

  @override
  State<BahagiPage> createState() => _BahagiPageState();
}

class _BahagiPageState extends State<BahagiPage> {
  bool isDarkMode = false;
  String appLanguage = 'ms';
  Color selectedColor = Colors.grey;
  int detectedVerticalLines = 0;
  List<Widget> paths = [];
  bool isLocked = false;

  double countDivisions() {
    return 3.14159; // Placeholder
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
              _buildResultHeader(dark),
              const SizedBox(height: 20),
              _buildControlBar(),
              const SizedBox(height: 10),
              Expanded(child: _buildCanvasPlaceholder()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultHeader(bool dark) {
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
              appLanguage == "ms"
                  ? "Hasil Bahagi ($detectedVerticalLines garis):"
                  : "Division Result ($detectedVerticalLines line/s):",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: dark ? Colors.yellow.shade200 : Colors.blue.shade300,
                shadows: [
                  Shadow(
                    color: dark ? Colors.yellow.withOpacity(0.2) : Colors.blue.withOpacity(0.2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 300,
              height: 40,
              alignment: Alignment.center,
              child: Text(
                countDivisions().toStringAsFixed(6),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: dark ? Colors.yellow.shade200 : Colors.blue.shade300,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              appLanguage == "ms" ? "Pilih warna dan lukis." : "Pick a color and draw.",
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

  Widget _buildControlBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 20,
        runSpacing: 10,
        children: [
          IconButton(
            icon: const Icon(Icons.undo, size: 32),
            color: Colors.grey,
            onPressed: () {
              if (paths.isNotEmpty) {
                setState(() {
                  paths.removeLast();
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
            itemBuilder: (context) => [
              _colorOption(Colors.red, "🔴 100"),
              _colorOption(Colors.blue, "🔵 10"),
              _colorOption(Colors.green, "🟢 1"),
              _colorOption(Colors.grey, "⚫ 0"),
              _colorOption(Colors.yellow, "🟡 -10"),
              _colorOption(Colors.purple, "🟣 -100"),
            ],
          ),
          IconButton(
            icon: Icon(
              isLocked ? Icons.lock : Icons.lock_open,
              size: 36,
              color: isLocked ? Colors.grey : Colors.blue,
            ),
            onPressed: () {
              setState(() {
                isLocked = !isLocked;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever, size: 32),
            color: Colors.grey,
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
}
