import 'package:flutter/material.dart';

class DarabPage extends StatefulWidget {
  const DarabPage({super.key});

  @override
  State<DarabPage> createState() => _DarabPageState();
}

class _DarabPageState extends State<DarabPage> {
  bool isDarkMode = false;
  String appLanguage = 'ms';
  Color selectedColor = Colors.grey;
  List<Widget> paths = [];

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
              appLanguage == "ms" ? "Hasil Darab:" : "Multiplication Result:",
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
              width: 200,
              height: 40,
              alignment: Alignment.center,
              child: Text(
                "0", // Placeholder for countIntersections
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
          const SizedBox(width: 20),
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
            ],
          ),
          const SizedBox(width: 20),
          IconButton(
            icon: const Icon(Icons.delete_forever, size: 32),
            color: Colors.grey,
            onPressed: () {
              setState(() {
                paths.clear();
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
