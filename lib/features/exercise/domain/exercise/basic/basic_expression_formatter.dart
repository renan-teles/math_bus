import '../exercise.dart';

class BasicExpressionFormatter {
  String format(Exercise exercise) {
    final operands = exercise.getOperands();
    final operation = exercise.getOperation();

    return operands.join(' ${operation.symbol} ');
  }
}
