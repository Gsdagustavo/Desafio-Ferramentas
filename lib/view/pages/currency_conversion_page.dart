import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

enum Currency { brl, eur, usd }

class CurrencyConversionPage extends StatefulWidget {
  const CurrencyConversionPage({super.key});

  @override
  State<CurrencyConversionPage> createState() => _CurrencyConversionPageState();
}

class _CurrencyConversionPageState extends State<CurrencyConversionPage> {
  final formKey = GlobalKey<FormState>();

  /// default conversion types
  Currency fromCurrency = Currency.brl;
  Currency toCurrency = Currency.usd;

  /// default conversion values
  var quantityToConvert = 0;
  var quantityConverted = 0;

  /// default result value
  var resultString = '';

  /// text controller for the value input
  final controller = TextEditingController();

  void convert() {

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

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),

          height: 550,
          width: 500,

          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
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

                TextFormField(
                  key: formKey,
                  controller: controller,

                  keyboardType: TextInputType.number,

                  onTapOutside: (_) => FocusScope.of(context).unfocus(),

                  onChanged: (value) {

                  },

                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),

                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffix: SizedBox(
                      width: 150,
                      height: 25,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// Country flag
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CountryFlag.fromCurrencyCode(
                              fromCurrency.name,
                            ),
                          ),

                          /// Select currency
                          DropdownButton<Currency>(
                            /// Currency name
                            underline: Text(
                              fromCurrency.name.toUpperCase(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            // underline: Container(color: Colors.transparent),
                            items: [
                              DropdownMenuItem(
                                value: Currency.brl,
                                child: Text('BRL'),
                              ),
                              DropdownMenuItem(
                                value: Currency.eur,
                                child: Text('EUR'),
                              ),
                              DropdownMenuItem(
                                value: Currency.usd,
                                child: Text('USD'),
                              ),
                            ],

                            onChanged: (value) {
                              setState(() {
                                if (value != null) {
                                  fromCurrency = value;
                                }
                              });
                            },
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
                    onTap: () {},
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
                  height: 68,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.black54),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(quantityConverted.toStringAsFixed(2)),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// Country flag
                          CountryFlag.fromCurrencyCode(toCurrency.name),

                          const SizedBox(width: 10),

                          /// Select currency
                          DropdownButton<Currency>(
                            /// Currency name
                            underline: Text(
                              toCurrency.name.toUpperCase(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            items: [
                              DropdownMenuItem(
                                value: Currency.brl,
                                child: Text('BRL'),
                              ),
                              DropdownMenuItem(
                                value: Currency.eur,
                                child: Text('EUR'),
                              ),
                              DropdownMenuItem(
                                value: Currency.usd,
                                child: Text('USD'),
                              ),
                            ],

                            onChanged: (value) {
                              setState(() {
                                if (value != null) {
                                  toCurrency = value;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Builder(
                      builder: (context) {
                        String fromCurrencyPrefix = '';
                        String toCurrencyPrefix = '';

                        switch (fromCurrency) {
                          case Currency.brl:
                            fromCurrencyPrefix = 'R\$';
                            break;
                          case Currency.eur:
                            fromCurrencyPrefix = '€';
                            break;
                          case Currency.usd:
                            fromCurrencyPrefix = '\$';
                            break;
                        }

                        switch (toCurrency) {
                          case Currency.brl:
                            toCurrencyPrefix = 'R\$';
                            break;
                          case Currency.eur:
                            toCurrencyPrefix = '€';
                            break;
                          case Currency.usd:
                            toCurrencyPrefix = '\$';
                            break;
                        }

                        String fromCurrencyText =
                            '$fromCurrencyPrefix $quantityToConvert ${fromCurrency.name.toUpperCase()}';
                        String toCurrencyText =
                            '$toCurrencyPrefix $quantityConverted ${toCurrency.name.toUpperCase()}';

                        return Text(
                          '$fromCurrencyText = $toCurrencyText',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        );
                      },
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
