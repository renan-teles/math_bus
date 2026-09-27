import 'exercise.dart';

class AnswerValidator {
  bool isCorrect(Exercise exercise, double userAnswer) {
    final correctAnswer = double.parse(
      exercise.getCorrectAnswer().toStringAsFixed(2),
    );

    final normalizedUserAnswer = double.parse(userAnswer.toStringAsFixed(2));
    return correctAnswer == normalizedUserAnswer;
  }
}
