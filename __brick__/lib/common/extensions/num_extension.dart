import 'package:intl/intl.dart';

extension NumExtensions on num {
  /// Returns:
  /// - int without decimals
  /// - double with max 2 decimals (floored, not rounded)
  /// - Always in English digits
  String toFixedString() {
    // Floor to 2 decimals if double
    final double value =
        (this is int) ? toDouble() : (this * 100).floor() / 100;

    // Remove trailing .0 for integers
    String result;
    if (value == value.floor()) {
      result = NumberFormat('#', 'en_US').format(value); // integer format
    } else {
      result = NumberFormat('#.##', 'en_US').format(value); // max 2 decimals
    }

    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      result = result.replaceAll(arabic[i], english[i]);
    }

    return result;
  }
}
