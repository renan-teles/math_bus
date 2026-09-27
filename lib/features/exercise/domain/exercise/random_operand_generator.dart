import 'dart:math';

class RandomOperandGenerator {
  static final int minOperand = -1000;
  static final int maxOperand = 1000;

  final Random _random;

  RandomOperandGenerator({required this._random});

  List<int> generate(int min, int max, int quantity) {
    if (min > max) {
      throw ArgumentError(
        'O valor mínimo não pode ser maior que o valor máximo.',
      );
    }

    if (min == max) {
      throw ArgumentError('O valor mínimo não pode ser igual ao valor máximo.');
    }

    if (min < minOperand || max < minOperand) {
      throw ArgumentError(
        'O valores mínimo e máximo não devem ser menores que $minOperand.',
      );
    }

    if (min > maxOperand || max > maxOperand) {
      throw ArgumentError(
        'Os valores minimo e máximo não devem ser maiores que $maxOperand.',
      );
    }

    if (quantity <= 1) {
      throw ArgumentError('A quantidade de operandos deve ser maior que 1.');
    }

    if (quantity > 4) {
      throw ArgumentError(
        'A quantidade de operandos não deve ser maior que 4.',
      );
    }

    final operands = <int>[];

    for (var i = 0; i < quantity; i++) {
      operands.add(min + _random.nextInt(max - min + 1));
    }

    return operands;
  }
}
