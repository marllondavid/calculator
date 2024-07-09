import 'operations.dart';

class Memory {
  final Calculator _calculator = Calculator();
  String _operation = '';
  bool _usedOperation = false;
  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  String _currentExpression = '';

  String get currentExpression => _currentExpression;
  String result = '0';

  Memory() {
    _clear();
  }

  void _clear() {
    result = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _bufferIndex = 0;
    _operation = '';
    _currentExpression = '';
    _usedOperation = false;
  }

  void applyCommand(String command) {
    if (command == 'AC') {
      _clear();
    } else if (command == 'DEL') {
      deleteEndDigit();
    } else if (Calculator.operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command);
    }
  }

  void deleteEndDigit() {
    result = result.length > 1 ? result.substring(0, result.length - 1) : '0';
  }

  void _addDigit(String digit) {
    if (_usedOperation) result = '0';

    if (result.contains('.') && digit == '.') digit = '';
    if (result == '0' && digit != '.') result = '';

    result += digit;

    double? parsedValue = double.tryParse(result);
    if (parsedValue != null) {
      _buffer[_bufferIndex] = parsedValue;
    }

    _currentExpression = _bufferIndex == 0
        ? result
        : '${_buffer[0].toString()} $_operation ${result.toString()}';

    _usedOperation = false;
  }

  void _setOperation(String operation) {
    if (_usedOperation && operation == _operation) return;

    if (_bufferIndex == 0) {
      _bufferIndex = 1;
    } else {
      _buffer[0] = _calculator.calculate(_buffer[0], _buffer[1], _operation);
    }

    if (operation != '=') {
      _operation = operation;
      _currentExpression = '${_buffer[0].toString()} $_operation';
    } else {
      _currentExpression = '';
    }

    result = _buffer[0].toString();
    result = result.endsWith('.0') ? result.split('.')[0] : result;
    _usedOperation = true;
  }
}
