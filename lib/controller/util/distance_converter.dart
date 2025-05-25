/// Util class to convert Distance units
abstract class DistanceConverter {
  static double centimetersToMeters(double centimeters) {
    return centimeters / 100;
  }

  static double centimetersToKilometers(double centimeters) {
    return centimeters / 100000;
  }

  static double metersToCentimeters(double meters) {
    return meters * 100;
  }

  static double metersToKilometers(double meters) {
    return meters / 1000;
  }

  static double kilometersToCentimeters(double kilometers) {
    return kilometers * 100000;
  }

  static double kilometersToMeters(double kilometers) {
    return kilometers * 1000;
  }
}