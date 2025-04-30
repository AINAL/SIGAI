import 'package:flutter/material.dart';

int countIntersections(List<List<Offset?>> paths, List<Color> colors) {
  int total = 0;
  final int pathCount = paths.length;

  for (int i = 0; i < pathCount; i++) {
    for (int j = i + 1; j < pathCount; j++) {
      if (pathsIntersect(paths[i], paths[j])) {
        final Color colorI = colors[i];
        final Color colorJ = colors[j];

        if (colorI == Colors.grey || colorJ == Colors.grey) continue;

        total += getColorMultiplier(colorI, colorJ);
      }
    }
  }

  return total;
}

double countDivisions(List<List<Offset?>> paths, List<Color> colors, {int? lockedVerticalLines}) {
  final int pathCount = paths.length;

  final int totalVerticalLines = lockedVerticalLines ??
      paths.where((path) {
        final first = path.firstWhere((p) => p != null, orElse: () => null);
        final last = path.lastWhere((p) => p != null, orElse: () => null);
        return first != null && last != null && (first.dx - last.dx).abs() < 30.0;
      }).length;

  double divisionSum = 0.0;
  for (int i = 0; i < totalVerticalLines; i++) {
    for (int j = 0; j < pathCount; j++) {
      if (i < colors.length && j < colors.length && pathsIntersect(paths[i], paths[j])) {
        if (colors[i] == Colors.grey || colors[j] == Colors.grey) continue;

        final factor = getColorMultiplier(colors[i], colors[j]);
        divisionSum += factor / totalVerticalLines;
      }
    }
  }

  return divisionSum;
}

int getColorMultiplier(Color color1, Color color2) {
  final red = Colors.red;
  final blue = Colors.blue;
  final green = Colors.green;
  final yellow = Colors.yellow;
  final purple = Colors.purple;

  final colorMultipliers = {
    red:    {red: 1.0, blue: 0.1, green: 0.01, yellow: 0.001, purple: 0.0001},
    blue:   {red: 10, blue: 1.0, green: 0.1, yellow: 0.01, purple: 0.001},
    green:  {red: 100, blue: 10, green: 1.0, yellow: 0.1, purple: 0.01},
    yellow: {red: 1000, blue: 100, green: 10, yellow: 1.0, purple: 0.1},
    purple: {red: 10000, blue: 1000, green: 100, yellow: 10, purple: 1.0},
  };

  return colorMultipliers[color1]?[color2]?.round() ?? 1;
}

bool pathsIntersect(List<Offset?> pathA, List<Offset?> pathB) {
  final aPoints = pathA.whereType<Offset>().toList();
  final bPoints = pathB.whereType<Offset>().toList();

  if (aPoints.length < 2 || bPoints.length < 2) return false;

  for (int i = 0; i < aPoints.length - 1; i++) {
    for (int j = 0; j < bPoints.length - 1; j++) {
      if (checkLineIntersection(aPoints[i], aPoints[i + 1], bPoints[j], bPoints[j + 1])) {
        return true;
      }
    }
  }
  return false;
}

bool checkLineIntersection(Offset p1, Offset p2, Offset q1, Offset q2) {
  Offset v1 = p2 - p1;
  Offset v2 = q2 - q1;
  Offset v3 = q1 - p1;
  Offset v4 = q2 - p1;

  double cross(Offset v, Offset w) => v.dx * w.dy - v.dy * w.dx;

  final cross1 = cross(v1, v3);
  final cross2 = cross(v1, v4);
  final cross3 = cross(v2, p1 - q1);
  final cross4 = cross(v2, p2 - q1);

  return (cross1 * cross2 < 0) && (cross3 * cross4 < 0);
}
