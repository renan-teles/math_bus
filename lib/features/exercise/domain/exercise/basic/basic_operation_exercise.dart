import 'package:math_bus/features/exercise/domain/exercise/exercise.dart';
import 'package:math_bus/features/exercise/domain/exercise/exercise_config.dart';
import 'package:math_bus/features/exercise/domain/exercise/basic/operation.dart';
import 'package:math_bus/features/exercise/domain/exercise/basic/operation_calculator.dart';
import 'package:math_bus/features/exercise/domain/exercise/random_operand_generator.dart';

class BasicOperationExercise implements Exercise {
  double _correctAnswer = 0;
  List<int> _operands = [];

  final OperationCalculator _calculator;
  final RandomOperandGenerator _generator;
  final Operation _operation;

  BasicOperationExercise({
    required this._calculator,
    required this._generator,
    required this._operation,
  });

  @override
  bool next(ExerciseConfig config) {
    try {
      final operands = _generator.generate(
        config.minOperand,
        config.maxOperand,
        config.operandsQuantity,
      );

      final correctAnswer = _calculator.calculate(operands, _operation);

      _operands = List.unmodifiable(operands);
      _correctAnswer = correctAnswer;

      return true;
    } on ArgumentError {
      return false;
    }
  }

  @override
  double getCorrectAnswer() => _correctAnswer;

  @override
  List<int> getOperands() => _operands;

  @override
  Operation getOperation() => _operation;
}
