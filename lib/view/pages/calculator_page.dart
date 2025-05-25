import 'package:ferramentas/controller/providers/calculator_provider.dart';
import 'package:ferramentas/view/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/calculator_button.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Calculadora'),

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
              child: Consumer<CalculatorProvider>(
                builder: (context, calculatorProvider, child) {
                  return Column(
                    children: [
                      /// Calculator visor
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          /// Previous calculation text
                          Text(
                            calculatorProvider.calculation,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          /// Input and result text
                          Text(
                            calculatorProvider.input,
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
                                        onTap: calculatorProvider.clearVisor,
                                      ),
                                    ),

                                    /// Modulus button
                                    Expanded(
                                      child: CalculatorButton(
                                        text: '%',
                                        onTap:
                                            () => calculatorProvider
                                                .onButtonTap('%'),
                                      ),
                                    ),

                                    /// Division button
                                    Expanded(
                                      child: CalculatorButton(
                                        text: '÷',
                                        onTap:
                                            () => calculatorProvider
                                                .onButtonTap('÷'),
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
                                        onTap:
                                            () => calculatorProvider
                                                .onButtonTap('7'),
                                      ),
                                    ),

                                    /// 8
                                    Expanded(
                                      child: CalculatorButton(
                                        text: '8',
                                        onTap:
                                            () => calculatorProvider
                                                .onButtonTap('8'),
                                      ),
                                    ),

                                    /// 9
                                    Expanded(
                                      child: CalculatorButton(
                                        text: '9',
                                        onTap:
                                            () => calculatorProvider
                                                .onButtonTap('9'),
                                      ),
                                    ),

                                    /// Multiplication button
                                    Expanded(
                                      child: CalculatorButton(
                                        text: 'X',
                                        onTap:
                                            () => calculatorProvider
                                                .onButtonTap('x'),
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
                                        onTap:
                                            () => calculatorProvider
                                                .onButtonTap('4'),
                                      ),
                                    ),

                                    /// 5
                                    Expanded(
                                      child: CalculatorButton(
                                        text: '5',
                                        onTap:
                                            () => calculatorProvider
                                                .onButtonTap('5'),
                                      ),
                                    ),

                                    /// 6
                                    Expanded(
                                      child: CalculatorButton(
                                        text: '6',
                                        onTap:
                                            () => calculatorProvider
                                                .onButtonTap('6'),
                                      ),
                                    ),

                                    /// Subtraction button
                                    Expanded(
                                      child: CalculatorButton(
                                        text: '-',
                                        onTap:
                                            () => calculatorProvider
                                                .onButtonTap('-'),
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
                                        onTap:
                                            () => calculatorProvider
                                                .onButtonTap('1'),
                                      ),
                                    ),

                                    /// 2
                                    Expanded(
                                      child: CalculatorButton(
                                        text: '2',
                                        onTap:
                                            () => calculatorProvider
                                                .onButtonTap('2'),
                                      ),
                                    ),

                                    /// 3
                                    Expanded(
                                      child: CalculatorButton(
                                        text: '3',
                                        onTap:
                                            () => calculatorProvider
                                                .onButtonTap('3'),
                                      ),
                                    ),

                                    /// Addition button
                                    Expanded(
                                      child: CalculatorButton(
                                        text: '+',
                                        onTap:
                                            () => calculatorProvider
                                                .onButtonTap('+'),
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
                                      onTap:
                                          () => calculatorProvider.onButtonTap(
                                            '0',
                                          ),
                                    ),
                                  ),

                                  /// Comma button
                                  Expanded(
                                    child: CalculatorButton(
                                      text: ',',
                                      onTap:
                                          () => calculatorProvider.onButtonTap(
                                            '.',
                                          ),
                                    ),
                                  ),

                                  /// Equals button
                                  Expanded(
                                    child: CalculatorButton(
                                      text: '=',
                                      onTap: calculatorProvider.calculate,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
