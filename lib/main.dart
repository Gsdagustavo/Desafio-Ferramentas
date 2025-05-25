import 'package:ferramentas/controller/providers/calculator_provider.dart';
import 'package:ferramentas/view/pages/calculator_page.dart';
import 'package:ferramentas/view/pages/currency_conversion_page.dart';
import 'package:ferramentas/view/pages/home_page.dart';
import 'package:ferramentas/view/pages/unit_conversion_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CalculatorProvider()),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColorDark: darkBlue,
        primaryColorLight: mediumBlue,
      ),

      debugShowCheckedModeBanner: false,
      title: 'Desafio Flutter Lince',

      routes: {
        '/': (_) => const HomePage(),
        '/currencyConversionPage': (_) => const CurrencyConversionPage(),
        '/unitConversionPage': (_) => const UnitConversionPage(),
        '/calculatorPage': (_) => const CalculatorPage(),
      },

      initialRoute: '/',
    );
  }
}
