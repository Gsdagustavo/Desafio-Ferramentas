/// Util class to convert Temperature units
abstract class TemperatureConverter {
  static double celsiusToFahrenheit(double celsius) {
    return ((9 / 5) * celsius) + 32;
  }

  static double celsiusToKelvin(double celsius) {
    return celsius + 273.15;
  }

  static double fahrenheitToCelsius(double fahrenheit) {
    return ((5 / 9) * (fahrenheit - 32));
  }

  static double fahrenheitToKelvin(double fahrenheit) {
    return (fahrenheit + 459.67) * (5 / 9);
  }

  static double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  static double kelvinToFahrenheit(double kelvin) {
    return 1.8 * (kelvin - 273.15) + 32;
  }
}