import 'package:ferramentas/controller/services/currency_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyProvider with ChangeNotifier {
  final CurrencyService currencyService;

  /// List of available [currencies]
  final List<dynamic> currencies = [];

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

  CurrencyProvider({this.currencyService = const CurrencyService()}) {
    _init();
  }

  void _init() async {
    await loadCurrencies();
  }

  /// Loads the available currencies from the API
  Future<void> loadCurrencies() async {
    isLoading = true;
    notifyListeners();

    try {
      final loadedCurrencies = await currencyService.fetchCurrencies();
      currencies.clear();
      currencies.addAll(loadedCurrencies);
      loadCurrenciesMenuItems();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Converts the currency via API request (post)
  Future<void> convertCurrency() async {
    try {
      final valueFactor = await currencyService.convertCurrency(
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
      );

      quantityConverted = quantityToConvert * valueFactor;

    } catch (e) {
      debugPrint(e.toString());
      notifyListeners();
    } finally {
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
