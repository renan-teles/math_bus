enum Operation {
  addition('+', '+', 'Adição'),
  subtraction('-', '-', 'Subtração'),
  multiplication('×', r'\times', 'Multiplicação'),
  division('÷', r'\div', 'Divisão');

  final String symbol;
  final String latexSymbol;
  final String name;

  const Operation(this.symbol, this.latexSymbol, this.name);
}
