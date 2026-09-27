import 'operation.dart';

class OperationCalculator {
  double calculate(List<int> operands, Operation operation) {
    if (operands.isEmpty) {
      throw ArgumentError('A lista de operandos não pode estar vazia.');
    }

    return switch (operation) {
      Operation.addition => _calculateAddition(operands),
      Operation.subtraction => _calculateSubtraction(operands),
      Operation.multiplication => _calculateMultiplication(operands),
      Operation.division => _calculateDivision(operands),
    };
  }

  double _calculateAddition(List<int> operands) {
    var result = operands.first.toDouble();

    for (var i = 1; i < operands.length; i++) {
      result += operands[i];
    }

    return result;
  }

  double _calculateSubtraction(List<int> operands) {
    var result = operands.first.toDouble();

    for (var i = 1; i < operands.length; i++) {
      result -= operands[i];
    }

    return result;
  }

  double _calculateMultiplication(List<int> operands) {
    var result = operands.first.toDouble();

    for (var i = 1; i < operands.length; i++) {
      result *= operands[i];
    }

    return result;
  }

  double _calculateDivision(List<int> operands) {
    var result = operands.first.toDouble();

    for (var i = 1; i < operands.length; i++) {
      final divisor = operands[i];

      if (divisor == 0) {
        throw ArgumentError('Não é possível realizar divisão por zero.');
      }

      result /= divisor;
    }

    return result;
  }
}
