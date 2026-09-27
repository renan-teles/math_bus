import 'package:math_bus/features/exercise/domain/exercise/answer_validator.dart';
import 'package:math_bus/features/exercise/domain/exercise/basic/basic_expression_formatter.dart';
import 'package:math_bus/features/exercise/domain/exercise/basic/basic_operation_exercise.dart';
import 'package:math_bus/features/exercise/domain/exercise/exercise_config.dart';

class BasicExerciseService {
  BasicOperationExercise _exercise;

  final AnswerValidator _answerValidator;
  final BasicExpressionFormatter _expressionFormatter;

  ExerciseConfig? _config;

  BasicExerciseService({
    required this._exercise,
    required this._answerValidator,
    required this._expressionFormatter,
  });

  void setExercise(BasicOperationExercise exercise) {
    _exercise = exercise;
  }

  void setConfig(ExerciseConfig config) {
    _config = config;
  }

  bool next() {
    final config = _config;

    if (config == null) {
      throw StateError('Configurações não definidas para exercício.');
    }

    return _exercise.next(config);
  }

  String getFormattedExpression() {
    return _expressionFormatter.format(_exercise);
  }

  bool checkAnswer(double userAnswer) {
    return _answerValidator.isCorrect(_exercise, userAnswer);
  }
}
