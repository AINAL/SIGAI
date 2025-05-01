import 'dart:math';

class GeneratedQuestion {
  final String questionText;
  final double expectedAnswer;

  GeneratedQuestion({required this.questionText, required this.expectedAnswer});
}

/// Generate random math question based on mode and digit complexity.
/// [mode] can be 'multiplication' or 'division'
/// [digits] determines how many digits to use (1 = 1-digit, 2 = 2-digit, etc)
GeneratedQuestion generateQuestion({required String mode, int digits = 1}) {
  final rand = Random();

  int min, max;
  if (digits == 1) {
    min = 1;
    max = 9;
  } else {
    min = pow(10, digits - 1).toInt();
    max = pow(10, digits).toInt() - 1;
  }

  if (mode == 'division') {
    int answer = rand.nextInt(max - min + 1) + min;
    int divisor = rand.nextInt(max - min + 1) + min;
    int dividend = answer * divisor;

    return GeneratedQuestion(
      questionText: "$dividend ÷ $divisor = ?",
      expectedAnswer: answer.toDouble(),
    );
  } else {
    int a = rand.nextInt(max - min + 1) + min;
    int b = rand.nextInt(max - min + 1) + min;

    return GeneratedQuestion(
      questionText: "$a × $b = ?",
      expectedAnswer: (a * b).toDouble(),
    );
  }
}