/// Util class to convert Weight units
abstract class WeightConverter {
  static double kilogramsToGrams(double kilograms) {
    return kilograms * 1000;
  }

  static double kilogramsToPounds(double kilograms) {
    return kilograms * 2.20462;
  }

  static double gramsToKilograms(double grams) {
    return grams / 1000;
  }

  static double gramsToPounds(double grams) {
    return grams / 453.59237;
  }

  static double poundsToKilograms(double pounds) {
    return pounds / 2.20462;
  }

  static double poundsToGrams(double pounds) {
    return pounds * 453.59237;
  }
}