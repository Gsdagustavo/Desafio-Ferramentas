import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String calculation = '';
  String input = '0';

  /// Adds a value to the input string when a valid button is pressed
  void onButtonTap(String value) {
    setState(() {
      input += value;
    });
  }

  /// Clears the result and input string
  void clearVisor() {
    setState(() {
      calculation = '';
      input = '';
    });
  }

  /// todo: implement actual calculation
  void calculate() {
    String expression = input;
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
    );
  }
}

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: onTap,
        child: Container(
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
    );
  }
}
