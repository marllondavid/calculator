class Calculator {
  static const operations = ['%', '/', '+', '-', '*', '='];

  double calculate(double a, double b, String operation) {
    switch (operation) {
      case '%':
        return a % b;
      case '/':
        return a / b;
      case '*':
        return a * b;
      case '+':
        return a + b;
      case '-':
        return a - b;
      default:
        throw ArgumentError('Operação desconhecida: $operation');
    }
  }
}
