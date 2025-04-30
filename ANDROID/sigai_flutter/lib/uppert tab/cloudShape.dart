import 'package:flutter/material.dart';
import 'dart:math';

// === Converted from CloudShapeB.swift ===
class CloudShapeBPainter extends CustomPainter {
  final bool isDarkMode;
  CloudShapeBPainter({required this.isDarkMode});
  @override
  void paint(Canvas canvas, Size size) {
    final colors = isDarkMode
        ? [
            const Color(0xFF2C1A4C).withOpacity(0.05),
            const Color(0xFF3B206B).withOpacity(0.1),
            const Color(0xFF4B2B7F).withOpacity(0.15),
            Colors.deepPurple.withOpacity(0.2),
            Colors.purple.withOpacity(0.25),
          ]
        : [
            const Color(0xFFFFDCE6),
            const Color(0xFFFFDCE6),
            Colors.white,
            Colors.white,
            const Color(0xFFDCF5FF),
            const Color(0xFFEbfaff),
            const Color(0xFFEbfaff),
          ];
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: colors,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    final path = Path();

    // Left most
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.3, size.height * 0.55), radius: size.height * 0.424 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.2, size.height * 0.45), radius: size.height * 0.52 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.1, size.height * 0.4), radius: size.height * 0.44 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.0, size.height * 0.55), radius: size.height * 0.52 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * -0.1, size.height * 0.45), radius: size.height * 0.56 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * -0.4, size.height * 0.55), radius: size.height * 0.52 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.5, size.height * 0.4), radius: size.height * 0.16 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 1.0, size.height * 0.55), radius: size.height * 0.48 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.7, size.height * 0.45), radius: size.height * 0.36 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 1.3, size.height * 0.4), radius: size.height * 0.44 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 1.0, size.height * 0.55), radius: size.height * 0.4 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.2, size.height * 0.6), radius: size.height * 0.2 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.25, size.height * 0.5), radius: size.height * 0.35 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.3, size.height * 0.45), radius: size.height * 0.35 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.35, size.height * 0.6), radius: size.height * 0.25 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.4, size.height * 0.5), radius: size.height * 0.35 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.45, size.height * 0.6), radius: size.height * 0.2 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.5, size.height * 0.45), radius: size.height * 0.25 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.55, size.height * 0.6), radius: size.height * 0.3 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.6, size.height * 0.5), radius: size.height * 0.25 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.65, size.height * 0.45), radius: size.height * 0.35 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.7, size.height * 0.6), radius: size.height * 0.2 * 0.75));
    

    // Bottom fill
    //path.addRect(Rect.fromLTWH(0, size.height / 2, size.width, size.height * 0.1));

    canvas.drawPath(path, paint);

    // Draw soft shadow under the cloud shape
    final shadowPaint = Paint()..color = Colors.black.withOpacity(0.08);
    final shadowPath = Path();
    for (final metric in path.computeMetrics()) {
      final extractPath = metric.extractPath(0, metric.length, startWithMoveTo: true);
      shadowPath.addPath(extractPath.shift(Offset(0, size.height * 0.01)), Offset.zero);
    }
    canvas.drawPath(shadowPath, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// === Converted from CloudShapeM.swift ===
class CloudShapeMPainter extends CustomPainter {
  final bool isDarkMode;
  CloudShapeMPainter({required this.isDarkMode});
  @override
  void paint(Canvas canvas, Size size) {
    final colors = isDarkMode
        ? [
            const Color(0xFF2C1A4C).withOpacity(0.05),
            const Color(0xFF3B206B).withOpacity(0.1),
            const Color(0xFF4B2B7F).withOpacity(0.15),
            Colors.deepPurple.withOpacity(0.2),
            Colors.purple.withOpacity(0.25),
          ]
        : [
            const Color(0xFFFFDCE6),
            const Color(0xFFFFDCE6),
            Colors.white,
            Colors.white,
            const Color(0xFFDCF5FF),
            const Color(0xFFEbfaff),
            const Color(0xFFEbfaff),
          ];
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: colors,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    final path = Path();

    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.05, size.height * 0.6), radius: size.height * 0.35 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.4, size.height * 0.5), radius: size.height * 0.4 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.45, size.height * 0.45), radius: size.height * 0.4 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.25, size.height * 0.6), radius: size.height * 0.45 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.1, size.height * 0.5), radius: size.height * 0.43 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.2, size.height * 0.6), radius: size.height * 0.31 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.5, size.height * 0.45), radius: size.height * 0.20 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.6, size.height * 0.6), radius: size.height * 0.4 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.6, size.height * 0.5), radius: size.height * 0.42 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.95, size.height * 0.45), radius: size.height * 0.45 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.75, size.height * 0.6), radius: size.height * 0.48 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.3, size.height * 0.55), radius: size.height * 0.424 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.2, size.height * 0.45), radius: size.height * 0.52 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.1, size.height * 0.4), radius: size.height * 0.44 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.0, size.height * 0.55), radius: size.height * 0.52 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * -0.1, size.height * 0.45), radius: size.height * 0.56 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * -0.4, size.height * 0.55), radius: size.height * 0.52 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.5, size.height * 0.4), radius: size.height * 0.16 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 1.0, size.height * 0.55), radius: size.height * 0.48 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.7, size.height * 0.45), radius: size.height * 0.36 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 1.3, size.height * 0.4), radius: size.height * 0.44 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 1.0, size.height * 0.55), radius: size.height * 0.4 * 0.75));

    //path.addRect(Rect.fromLTWH(0, size.height / 2, size.width, size.height * 0.1));

    canvas.drawPath(path, paint);

    // Draw soft shadow under the cloud shape
    final shadowPaint = Paint()..color = Colors.black.withOpacity(0.08);
    final shadowPath = Path();
    for (final metric in path.computeMetrics()) {
      final extractPath = metric.extractPath(0, metric.length, startWithMoveTo: true);
      shadowPath.addPath(extractPath.shift(Offset(0, size.height * 0.01)), Offset.zero);
    }
    canvas.drawPath(shadowPath, shadowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// === Converted from CloudShapeF.swift ===
class CloudShapeFPainter extends CustomPainter {
  final bool isDarkMode;
  CloudShapeFPainter({required this.isDarkMode});
  @override
  void paint(Canvas canvas, Size size) {
    final colors = isDarkMode
        ? [
            const Color(0xFF2C1A4C).withOpacity(0.05),
            const Color(0xFF3B206B).withOpacity(0.1),
            const Color(0xFF4B2B7F).withOpacity(0.15),
            Colors.deepPurple.withOpacity(0.2),
            Colors.purple.withOpacity(0.25),
          ]
        : [
            const Color(0xFFFFDCE6),
            const Color(0xFFFFDCE6),
            Colors.white,
            Colors.white,
            const Color(0xFFDCF5FF),
            const Color(0xFFEbfaff),
            const Color(0xFFEbfaff),
          ];
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: colors,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    final path = Path();

    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.2, size.height * 0.6), radius: size.height * 0.2 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.25, size.height * 0.5), radius: size.height * 0.35 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.3, size.height * 0.45), radius: size.height * 0.35 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.35, size.height * 0.6), radius: size.height * 0.25 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.4, size.height * 0.5), radius: size.height * 0.35 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.45, size.height * 0.6), radius: size.height * 0.2 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.5, size.height * 0.45), radius: size.height * 0.25 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.55, size.height * 0.6), radius: size.height * 0.3 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.6, size.height * 0.5), radius: size.height * 0.25 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.65, size.height * 0.45), radius: size.height * 0.35 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.7, size.height * 0.6), radius: size.height * 0.2 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.05, size.height * 0.6), radius: size.height * 0.35 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.4, size.height * 0.5), radius: size.height * 0.4 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.45, size.height * 0.45), radius: size.height * 0.4 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.25, size.height * 0.6), radius: size.height * 0.45 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.6, size.height * 0.5), radius: size.height * 0.43 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.7, size.height * 0.6), radius: size.height * 0.31 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.5, size.height * 0.45), radius: size.height * 0.50 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.6, size.height * 0.6), radius: size.height * 0.4 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.6, size.height * 0.5), radius: size.height * 0.42 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.95, size.height * 0.45), radius: size.height * 0.45 * 0.75));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.75, size.height * 0.6), radius: size.height * 0.48 * 0.75));

    //path.addRect(Rect.fromLTWH(0, size.height / 2, size.width, size.height * 0.8));

    canvas.drawPath(path, paint);

    // Draw soft shadow under the cloud shape
    final shadowPaint = Paint()..color = Colors.black.withOpacity(0.08);
    final shadowPath = Path();
    for (final metric in path.computeMetrics()) {
      final extractPath = metric.extractPath(0, metric.length, startWithMoveTo: true);
      shadowPath.addPath(extractPath.shift(Offset(0, size.height * 0.01)), Offset.zero);
    }
    canvas.drawPath(shadowPath, shadowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// === Converted from StarScatterShape.swift ===
class StarScatterPainter extends CustomPainter {
  final List<Offset> positions;
  final List<double> sizes;
  final Color color;

  StarScatterPainter({
    int numberOfStars = 60,
    double minSize = 0.5,
    double maxSize = 2.0,
    this.color = Colors.white,
  })  : positions = _generateStarPositions(numberOfStars),
        sizes = _generateStarSizes(numberOfStars, minSize, maxSize);

  static List<Offset> _generateStarPositions(int count) {
    final rand = Random(42); // Fixed seed for consistency
    return List.generate(count, (_) => Offset(rand.nextDouble(), rand.nextDouble() * 0.6));
  }

  static List<double> _generateStarSizes(int count, double min, double max) {
    final rand = Random(42);
    return List.generate(count, (_) => min + rand.nextDouble() * (max - min));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withOpacity(0.8);
    final path = Path();

    for (int i = 0; i < positions.length; i++) {
      final x = positions[i].dx * size.width;
      final y = positions[i].dy * size.height;
      final starSize = sizes[i];
      path.addOval(Rect.fromCircle(center: Offset(x, y), radius: starSize));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
