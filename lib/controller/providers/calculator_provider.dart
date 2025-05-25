import 'package:flutter/cupertino.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorProvider with ChangeNotifier {
  /// Represents all possible numbers of the calculator
  static const List<String> numbers = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '0',
  ];

  /// Represents all action of the calculator
  static const List<String> actions = ['ac', '=', '%', '-', '+', 'x', '÷'];

  String calculation = '';
  String input = '0';

  bool isFirstExpression = true;
  bool wasLastExpressionCleansed = false;

  void calculate() {
    calculation += input;
    debugPrint('calculation: $calculation');
    String expression = calculation;

    expression = expression.replaceAll('÷', '/');
    expression = expression.replaceAll('x', '*');

    ExpressionParser parser = GrammarParser();
    Expression exp = parser.parse(expression);
    ContextModel contextModel = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, contextModel);
    debugPrint(eval.toString());
    calculation += ' = ';
    input = eval.toString();

    notifyListeners();
  }

  /// Adds a value to the input string when a valid button is pressed
  void onButtonTap(String value) {
    if (value == 'ac') {
      clearVisor();
      notifyListeners();
      return;
    }

    if (value == '=') {
      calculate();
      notifyListeners();
      return;
    }

    if (!isFirstExpression && !wasLastExpressionCleansed) {
      input = '';
      wasLastExpressionCleansed = true;
    }

    bool isValuePoint = value == ',' || value == '.';

    if (numbers.contains(value) || isValuePoint) {
      if (input == '0') {
        input = '';
      }

      bool containsPoint = input.contains(',') || input.contains('.');

      debugPrint('is value point: $isValuePoint');
      debugPrint('contains point: $containsPoint');

      if (isValuePoint) {
        if (!containsPoint) {
          if (input.isEmpty) {
            input = '0.';
            notifyListeners();
            return;
          } else {
            input += '.';
            notifyListeners();
            return;
          }
        } else {
          notifyListeners();
          return;
        }
      }

      input += value;
      notifyListeners();
    } else if (actions.contains(value)) {
      if (input.isEmpty) {
        notifyListeners();
        return;
      }

      calculation = '$input $value';
      input = '';
      notifyListeners();
    } else {
      throw Exception('Invalid input for the calculator');
    }
  }

  /// Clears the result and input string
  void clearVisor() {
    calculation = '';
    input = '';
    notifyListeners();
  }
}
