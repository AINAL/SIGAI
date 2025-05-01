import 'package:flutter/material.dart';
import 'package:sigai_flutter/mainfunc/calculate.dart' show countIntersections;

class DarabPage extends StatefulWidget {
  final String appLanguage;
  const DarabPage({super.key, required this.appLanguage});

  @override
  State<DarabPage> createState() => _DarabPageState();
}

class _DarabPageState extends State<DarabPage> {
  bool isDarkMode = false;
  late String appLanguage;
  Color selectedColor = Colors.grey;
  List<List<Offset?>> strokes = [];
  List<Color> strokeColors = [];

  @override
  void initState() {
    super.initState();
    appLanguage = widget.appLanguage;
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = isDarkMode || Theme.of(context).brightness == Brightness.dark;
    final gradientColors = dark
        ? [Colors.black,  const Color.fromARGB(255, 57, 56, 56), const Color.fromARGB(255, 130, 130, 130), Colors.white,]
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
              const SizedBox(height: 8),
              _buildControlBar(),
              const SizedBox(height: 4),
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
            SizedBox(
              width: double.infinity,
              height: 40,
              child: Center(
                child: Text(
                  (() {
                    final count = countIntersections(strokes, strokeColors);
                    print("Intersection Count: $count");
                    return count.toString();
                  })(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: dark ? Colors.yellow.shade200 : Colors.blue.shade300,
                  ),
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
              setState(() {
                if (strokes.isNotEmpty) {
                  strokes.removeLast();
                  strokeColors.removeLast();
                }
              });
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
                strokes.clear();
                strokeColors.clear();
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomPaint(
          painter: _DrawingPainter(strokes, strokeColors),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final List<List<Offset?>> strokes;
  final List<Color> strokeColors;

  _DrawingPainter(this.strokes, this.strokeColors);

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
