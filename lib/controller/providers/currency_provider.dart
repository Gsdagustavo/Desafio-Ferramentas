import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../core/constants/urls.dart';

class CurrencyProvider with ChangeNotifier {
  /// List of available [currencies]
  final List<String> currencies = [];

  /// List of [DropdownMenuItem] to be used in the [DropdownButton] to change the currencies
  List<DropdownMenuItem<String>> items = [];

  bool isLoading = false;

  String fromCurrency = '';
  String toCurrency = '';

  /// Default conversion values
  double quantityToConvert = 0;
  double quantityConverted = 0;

  /// Text controller for the value input
  final controller = TextEditingController();

  CurrencyProvider() {
    _init();
  }

  void _init() async {
    await loadCurrencies();
  }

  /// Loads the available currencies from the API
  Future<void> loadCurrencies() async {
    isLoading = true;

    try {
      final response = await http.get(Uri.parse(getCurrenciesUrl));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List<dynamic>;

        for (final currency in body) {
          currencies.add(currency);
        }

        loadCurrenciesMenuItems();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Converts the currency via API request (post)
  void convertCurrency() async {
    try {
      final response = await http.post(
        Uri.parse(convertCurrencyUrl),
        body: jsonEncode({'de': fromCurrency, 'para': toCurrency}),
      );

      if (response.statusCode == 200) {
        final double valueFactor = jsonDecode(response.body)['conversao'];

        quantityConverted = quantityToConvert * valueFactor;
      }
    } catch (e) {
      debugPrint(e.toString());
      notifyListeners();
    }
  }

  /// Set default values for the currencies
  void setDefaultValues() {
    if (currencies.isNotEmpty) {
      fromCurrency = currencies.first;
      toCurrency = currencies.length > 1 ? currencies[1] : currencies.first;
    }

    notifyListeners();
  }

  /// Swap the currencies
  void swapCurrencies() {
    final tempCurrency = toCurrency;
    toCurrency = fromCurrency;
    fromCurrency = tempCurrency;
    notifyListeners();
  }

  /// After the currencies are loaded, the [items] list is generated based
  /// on the currencies list
  void loadCurrenciesMenuItems() {
    items = List.generate(currencies.length, (index) {
      final String currency = currencies[index];
      return DropdownMenuItem(value: currency, child: Text(currency));
    });
  }

  String getFormattedCurrency(double value, String currencyCode) {
    final formatter = NumberFormat.simpleCurrency(name: currencyCode);
    return formatter.format(value);
  }
}
