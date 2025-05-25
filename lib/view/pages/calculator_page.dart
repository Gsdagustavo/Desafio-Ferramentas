import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

/// Represents all possible numbers of the calculator
const List<String> numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];

/// Represents all action of the calculator
const List<String> actions = ['ac', '=', '%', '-', '+', 'x', '÷'];

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String calculation = '';
  String input = '0';

  bool isFirstExpression = true;
  bool wasLastExpressionCleansed = false;

  /// Adds a value to the input string when a valid button is pressed
  void onButtonTap(String value) {
    setState(() {
      if (value == 'ac') {
        clearVisor();
        return;
      }

      if (value == '=') {
        calculate();
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
              return;
            } else {
              input += '.';
              return;
            }
          } else {
            return;
          }
        }

        input += value;
      } else if (actions.contains(value)) {
        if (input.isEmpty) {
          return;
        }

        calculation = '$input $value';
        input = '';
      } else {
        throw Exception('Invalid input for the calculator');
      }
    });
  }

  /// Clears the result and input string
  void clearVisor() {
    setState(() {
      calculation = '';
      input = '';
    });
  }

  void calculate() {
    setState(() {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Calculadora',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),

      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 650,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),

            /// Main column
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  /// Calculator visor
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /// Previous calculation text
                      Text(
                        calculation,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      /// Input and result text
                      Text(
                        input,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Divider(color: Theme.of(context).primaryColorLight),
                    ],
                  ),

                  /// Calculator keypad
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          /// First row
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                /// AC button
                                Expanded(
                                  flex: 2,
                                  child: CalculatorButton(
                                    text: 'AC',
                                    onTap: clearVisor,
                                  ),
                                ),

                                /// Modulus button
                                Expanded(
                                  child: CalculatorButton(
                                    text: '%',
                                    onTap: () => onButtonTap('%'),
                                  ),
                                ),

                                /// Division button
                                Expanded(
                                  child: CalculatorButton(
                                    text: '÷',
                                    onTap: () => onButtonTap('÷'),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Second row
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                /// 7
                                Expanded(
                                  child: CalculatorButton(
                                    text: '7',
                                    onTap: () => onButtonTap('7'),
                                  ),
                                ),

                                /// 8
                                Expanded(
                                  child: CalculatorButton(
                                    text: '8',
                                    onTap: () => onButtonTap('8'),
                                  ),
                                ),

                                /// 9
                                Expanded(
                                  child: CalculatorButton(
                                    text: '9',
                                    onTap: () => onButtonTap('9'),
                                  ),
                                ),

                                /// Multiplication button
                                Expanded(
                                  child: CalculatorButton(
                                    text: 'X',
                                    onTap: () => onButtonTap('x'),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Third row
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                /// 4
                                Expanded(
                                  child: CalculatorButton(
                                    text: '4',
                                    onTap: () => onButtonTap('4'),
                                  ),
                                ),

                                /// 5
                                Expanded(
                                  child: CalculatorButton(
                                    text: '5',
                                    onTap: () => onButtonTap('5'),
                                  ),
                                ),

                                /// 6
                                Expanded(
                                  child: CalculatorButton(
                                    text: '6',
                                    onTap: () => onButtonTap('6'),
                                  ),
                                ),

                                /// Subtraction button
                                Expanded(
                                  child: CalculatorButton(
                                    text: '-',
                                    onTap: () => onButtonTap('-'),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Fourth row
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                /// 1
                                Expanded(
                                  child: CalculatorButton(
                                    text: '1',
                                    onTap: () => onButtonTap('1'),
                                  ),
                                ),

                                /// 2
                                Expanded(
                                  child: CalculatorButton(
                                    text: '2',
                                    onTap: () => onButtonTap('2'),
                                  ),
                                ),

                                /// 3
                                Expanded(
                                  child: CalculatorButton(
                                    text: '3',
                                    onTap: () => onButtonTap('3'),
                                  ),
                                ),

                                /// Addition button
                                Expanded(
                                  child: CalculatorButton(
                                    text: '+',
                                    onTap: () => onButtonTap('+'),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Fifth (and last) row
                          Row(
                            children: [
                              /// 0
                              Expanded(
                                flex: 2,
                                child: CalculatorButton(
                                  text: '0',
                                  onTap: () => onButtonTap('0'),
                                ),
                              ),

                              /// Comma button
                              Expanded(
                                child: CalculatorButton(
                                  text: ',',
                                  onTap: () => onButtonTap('.'),
                                ),
                              ),

                              /// Equals button
                              Expanded(
                                child: CalculatorButton(
                                  text: '=',
                                  onTap: calculate,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),

          child: Ink(
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).primaryColorLight,
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
