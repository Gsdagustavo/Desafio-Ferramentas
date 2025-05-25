import 'package:flutter/material.dart';

enum DistanceUnit { centimeters, meters, kilometers }

enum WeightUnit { kilograms, pounds, grams }

enum TemperatureUnit { celsius, fahrenheit, kelvin }

enum Type { distance, weight, temperature }

class UnitConversionPage extends StatefulWidget {
  const UnitConversionPage({super.key});

  @override
  State<UnitConversionPage> createState() => _UnitConversionPageState();
}

class _UnitConversionPageState extends State<UnitConversionPage> {
  final formKey = GlobalKey<FormState>();

  /// default conversion types
  Type? type;

  /// default conversion values
  var quantityToConvert = 0;
  var quantityConverted = 0;

  /// default result value
  var resultString = '';

  /// text controller for the value input
  final controller = TextEditingController();

  void convert() {
    String value = 'dfult';

    if (type != null) {
      value = type.toString();
    }

    debugPrint('converting... $value');
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
          'Conversor de unidades',
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

          height: 500,
          width: 500,

          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Select the conversion type (distance, temperature, etc...)
                Text(
                  'Tipo',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),

                const SizedBox(height: 15),

                Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: DropdownButton<Type>(
                    isExpanded: true,
                    underline: Container(color: Colors.transparent),

                    hint: Builder(
                      builder: (context) {
                        var text;

                        if (type != null) {
                          switch (type) {
                            case Type.distance:
                              text = 'Distância';
                              break;
                            case Type.weight:
                              text = 'Peso';
                              break;
                            case Type.temperature:
                              text = 'Temperatura';
                              break;
                            case null:
                              // TODO: Handle this case.
                              throw UnimplementedError();
                          }
                        }

                        return Text(
                          type != null
                              ? text
                              : 'Distância, peso, temperatura...',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        );
                      },
                    ),

                    borderRadius: BorderRadius.circular(12),

                    items: [
                      DropdownMenuItem(
                        value: Type.distance,
                        child: Text('Distância'),
                      ),
                      DropdownMenuItem(value: Type.weight, child: Text('Peso')),
                      DropdownMenuItem(
                        value: Type.temperature,
                        child: Text('Temperatura'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        type = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 25),

                /// Insert value to convert
                Text(
                  'Quantia',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),

                TextFormField(
                  key: formKey,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  validator: (String? value) {
                    int? doubleValue = int.tryParse(value ?? '');

                    if (doubleValue == null) {
                      return 'Valor invalido';
                    }

                    return null;
                  },

                  // onChanged: (_) {
                  //   if (formKey.currentState!.validate()) {
                  //     convert();
                  //   }
                  // },
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
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
