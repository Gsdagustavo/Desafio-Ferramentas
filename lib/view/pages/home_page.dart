import 'package:flutter/material.dart';

import '../../core/constants/sizes.dart';
import '../../core/constants/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 100),

            /// Imagem principal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Image.asset(
                'assets/lince_tech_academy.png',
                fit: BoxFit.fill,
              ),
            ),

            const SizedBox(height: 50),

            /// Conversor de moedas e medidas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /// Conversor de moedas
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/currencyConversionPage');
                      },

                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).primaryColorLight,
                        ),

                        width: upperButtonsSize,
                        height: upperButtonsSize,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('assets/moeda.png'),
                            Expanded(
                              child: Text(
                                'Conversor de moedas',
                                style: textStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                /// Conversor de medidas
                Column(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(20),

                      onTap: () {
                        Navigator.pushNamed(context, '/unitConversionPage');
                      },

                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).primaryColorLight,
                        ),

                        width: upperButtonsSize,
                        height: upperButtonsSize,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('assets/regua.png', width: 100),
                            Expanded(
                              child: Text(
                                'Conversor de medidas',
                                style: textStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 50),

            /// Calculadora
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/calculadora.png', scale: 3),
                  Text('Calculadora', style: textStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
