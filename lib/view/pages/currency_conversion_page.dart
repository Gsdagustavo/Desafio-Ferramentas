import 'dart:convert';

import 'package:country_flags/country_flags.dart';
import 'package:ferramentas/view/pages/unit_conversion_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const String getCurrenciesUrl =
    'https://cruiserdev.lince.com.br/academy/moedas';
const String convertCurrencyUrl =
    'https://cruiserdev.lince.com.br/academy/converter';

class CurrencyConversionPage extends StatefulWidget {
  const CurrencyConversionPage({super.key});

  @override
  State<CurrencyConversionPage> createState() => _CurrencyConversionPageState();
}

class _CurrencyConversionPageState extends State<CurrencyConversionPage> {
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

  /// Loads the available currencies from the API
  void loadCurrencies() async {
    setState(() {
      isLoading = true;
    });

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
      setState(() {
        isLoading = false;
      });
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

        setState(() {
          quantityConverted = quantityToConvert * valueFactor;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// After the currencies are loaded, the [items] list is generated based
  /// on the currencies list
  void loadCurrenciesMenuItems() {
    items = List.generate(currencies.length, (index) {
      final String currency = currencies[index];
      return DropdownMenuItem(value: currency, child: Text(currency));
    });
  }

  /// Set default values for the currencies
  void setDefaultValues() {
    if (currencies.isNotEmpty) {
      fromCurrency = currencies.first;
      toCurrency = currencies.length > 1 ? currencies[1] : currencies.first;
    }
  }

  /// Swap the currencies
  void swapCurrencies() {
    setState(() {
      final tempCurrency = toCurrency;
      toCurrency = fromCurrency;
      fromCurrency = tempCurrency;
    });
  }

  String getFormattedCurrency(double value, String currencyCode) {
    final formatter = NumberFormat.simpleCurrency(name: currencyCode);
    return formatter.format(value);
  }

  @override
  void initState() {
    super.initState();
    loadCurrencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(
          'Conversor de moedas',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),

      /// [SingleChildScrollView] to avoid overflow then the text field is focused
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          /// Main container
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),

            height: 550,
            width: 500,

            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Builder(
                builder: (context) {
                  /// Shows a [CircularProgressIndicator] while the [loadCurrencies]
                  /// method is still executing
                  if (isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  /// Main column
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quantia',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      /// Text field to enter the value
                      TextFormField(
                        controller: controller,

                        /// Allows only numbers
                        keyboardType: TextInputType.number,

                        /// Pop the keyboard when tap outside
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),

                        /// The currency is converted then the user interacts
                        /// with the text field
                        onChanged: (value) {
                          setState(() {
                            quantityToConvert = double.tryParse(value) ?? 0;
                          });

                          convertCurrency();
                        },

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),

                          /// This is needed for the label to keep visible
                          /// even if the text field is not focused
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffix: SizedBox(
                            width: 150,
                            height: 35,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /// Country flag
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: CountryFlag.fromCurrencyCode(
                                    fromCurrency.toUpperCase(),
                                  ),
                                ),

                                /// Dropdown button
                                CustomDropdownButton(
                                  items: items,
                                  onChanged: (String? value) {
                                    setState(() {
                                      if (value != null) {
                                        fromCurrency = value;
                                        convertCurrency();
                                      }
                                    });
                                  },
                                  label: fromCurrency,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: InkWell(
                          /// change currencies
                          onTap: () {
                            /// swap the currencies and automatically converts them
                            swapCurrencies();
                            convertCurrency();
                          },

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_upward,
                                color: Theme.of(context).primaryColorLight,
                                size: 50,
                              ),
                              Icon(
                                Icons.arrow_downward,
                                color: Theme.of(context).primaryColorLight,
                                size: 50,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Text(
                        'Converter para',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      Container(
                        height: 67,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1, color: Colors.black54),
                        ),

                        /// Row that shows the info about the converted currency
                        /// (conversion and country flag)
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(quantityConverted.toStringAsFixed(2)),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /// Country flag
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: CountryFlag.fromCurrencyCode(
                                    toCurrency,
                                  ),
                                ),

                                /// Dropdown button
                                CustomDropdownButton(
                                  label: toCurrency,
                                  items: items,
                                  onChanged: (String? value) {
                                    setState(() {
                                      if (value != null) {
                                        toCurrency = value;
                                        convertCurrency();
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      /// Conversion result text
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            children: [
                              Builder(
                                builder: (context) {
                                  String formattedFromCurrency =
                                      getFormattedCurrency(
                                        quantityToConvert,
                                        fromCurrency,
                                      );
                                  String formattedToCurrency =
                                      getFormattedCurrency(
                                        quantityConverted,
                                        toCurrency,
                                      );

                                  String fromCurrencyText =
                                      '$formattedFromCurrency $fromCurrency';
                                  String toCurrencyText =
                                      '$formattedToCurrency $toCurrency';

                                  return Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '$fromCurrencyText = ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),

                                        TextSpan(
                                          text: toCurrencyText,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).primaryColorLight,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                child: DateSpan(),
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

/// This widget is a [DropdownButton] that holds custom values given in the
/// constructor
///
/// This widget is intended to be used to list all the currencies available
/// from the API, although it can be implemented in the [UnitConversionPage]
/// as well
class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.onChanged,
    required this.label,
  });

  final List<DropdownMenuItem<String>> items;
  final void Function(String?) onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton<String>(
        items: items,
        onChanged: onChanged,

        /// Currency name
        underline: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class DateSpan extends StatefulWidget {
  const DateSpan({super.key});

  @override
  State<DateSpan> createState() => _DateSpanState();
}

class _DateSpanState extends State<DateSpan> {
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/mm/yyyy');
    final hourFormat = DateFormat('HH:mm');

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Cotação feita em ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          ),

          TextSpan(
            text: dateFormat.format(DateTime.now()),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColorLight,
              fontSize: 15,
            ),
          ),

          TextSpan(
            text: ' às ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          ),

          TextSpan(
            text: hourFormat.format(DateTime.now()),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColorLight,
              fontSize: 15,
            ),
          ),

          TextSpan(
            text: ' UTC',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
