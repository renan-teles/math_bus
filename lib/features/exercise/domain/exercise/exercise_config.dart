import 'package:math_bus/features/exercise/domain/exercise/basic/operation.dart';

class ExerciseConfig {
  final int questionsQuantity;
  final int operandsQuantity;

  final int minOperand;
  final int maxOperand;

  final Operation operation;

  const ExerciseConfig({
    required this.questionsQuantity,
    required this.minOperand,
    required this.maxOperand,
    required this.operandsQuantity,
    required this.operation,
  });
}
