import 'package:country_flags/country_flags.dart';
import 'package:ferramentas/controller/providers/currency_provider.dart';
import 'package:ferramentas/view/pages/unit_conversion_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/base_app_bar.dart';

class CurrencyConversionPage extends StatelessWidget {
  const CurrencyConversionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: BaseAppBar(title: 'Conversor de moedas'),

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

            width: 500,

            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Consumer<CurrencyProvider>(
                builder: (context, currencyProvider, child) {
                  /// Shows a [CircularProgressIndicator] while the [loadCurrencies]
                  /// method is still executing
                  if (currencyProvider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  /// Main column
                  return Column(
                    mainAxisSize: MainAxisSize.min,
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
                        controller: currencyProvider.controller,

                        /// Allows only numbers
                        keyboardType: TextInputType.number,

                        /// Pop the keyboard when tap outside
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),

                        /// The currency is converted then the user interacts
                        /// with the text field
                        onChanged: (value) {
                          currencyProvider.quantityToConvert =
                              double.tryParse(value) ?? 0;

                          currencyProvider.convertCurrency();
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
                                    currencyProvider.fromCurrency.toUpperCase(),
                                  ),
                                ),

                                /// Dropdown button
                                CustomDropdownButton(
                                  items: currencyProvider.items,
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      currencyProvider.fromCurrency = value;
                                      currencyProvider.convertCurrency();
                                    }
                                  },
                                  label: currencyProvider.fromCurrency,
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
                            currencyProvider.swapCurrencies();
                            currencyProvider.convertCurrency();
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
                              child: Text(
                                currencyProvider.quantityConverted
                                    .toStringAsFixed(2),
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /// Country flag
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: CountryFlag.fromCurrencyCode(
                                    currencyProvider.toCurrency,
                                  ),
                                ),

                                /// Dropdown button
                                CustomDropdownButton(
                                  label: currencyProvider.toCurrency,
                                  items: currencyProvider.items,
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      currencyProvider.toCurrency = value;
                                      currencyProvider.convertCurrency();
                                    }
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
                                      currencyProvider.getFormattedCurrency(
                                        currencyProvider.quantityToConvert,
                                        currencyProvider.fromCurrency,
                                      );
                                  String formattedToCurrency = currencyProvider
                                      .getFormattedCurrency(
                                        currencyProvider.quantityConverted,
                                        currencyProvider.toCurrency,
                                      );

                                  String fromCurrencyText =
                                      '$formattedFromCurrency ${currencyProvider.fromCurrency}';
                                  String toCurrencyText =
                                      '$formattedToCurrency ${currencyProvider.toCurrency}';

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

class DateSpan extends StatelessWidget {
  const DateSpan({super.key});

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
