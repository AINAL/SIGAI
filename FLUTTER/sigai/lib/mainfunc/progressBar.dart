import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionProgressBar extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final int level;
  final double progress;

  const QuestionProgressBar({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.level,
    required this.progress,
  });

  Future<Map<String, int>> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'correctAnswers': prefs.getInt('correctAnswers') ?? 0,
      'totalQuestions': prefs.getInt('totalQuestions') ?? 0,
      'level': prefs.getInt('level') ?? 1,
    };
  }

  Future<void> saveProgress({
    required int correctAnswers,
    required int totalQuestions,
    required int level,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('correctAnswers', correctAnswers);
    await prefs.setInt('totalQuestions', totalQuestions);
    await prefs.setInt('level', level);
  }

  @override
  Widget build(BuildContext context) {
    final int maxQuestions = 5 + (level * 3);
    final double computedProgress = correctAnswers / maxQuestions;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 30,
      child: Row(
        children: [
          // Percentage on the left
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '${(computedProgress * 100).toInt()}%',
              style: TextStyle(
                color: isDark ? Colors.white : const Color(0xFFFFC1E3),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Progress bar in the middle
          Expanded(
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isDark ? Colors.black : const Color(0xFFE0F7FA),
              ),
              child: Stack(
                children: [
                  FractionallySizedBox(
                    widthFactor: computedProgress.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: isDark
                              ? [Colors.black, Colors.yellow]
                              : [const Color(0xFFE0F7FA), const Color(0xFFFFC1E3)],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Level on the right
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Lv $level',
              style: TextStyle(
                color: isDark ? Colors.yellow : const Color(0xFFFFC1E3),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}