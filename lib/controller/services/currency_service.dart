import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants/urls.dart';

class CurrencyService {

  const CurrencyService();

  /// Loads the available currencies from the API
  Future<List<dynamic>> fetchCurrencies() async {
    final response = await http.get(Uri.parse(getCurrenciesUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load currencies');
    }
  }

  /// Converts the currency via API request (post)
  Future<double> convertCurrency({
    required String fromCurrency,
    required String toCurrency,
  }) async {
    final response = await http.post(
      Uri.parse(convertCurrencyUrl),
      body: jsonEncode({'de': fromCurrency, 'para': toCurrency}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['conversao'] as double;
    } else {
      throw Exception('Failed to conver currency');
    }
  }
}
