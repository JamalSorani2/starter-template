import '../imports/imports.dart';

class ValidationHelper {
  static Map<String, String Function(Object)>? validationMessages(
    String? minLengthValidator, {
    final num? maxValue,
    final num? minValue,
  }) {
    return {
      ValidationMessage.required: (e) => AppString.thisFieldRequired,
      ValidationMessage.email: (e) => AppString.validEmail,
      ValidationMessage.minLength: (e) =>
          minLengthValidator ?? AppString.passwordMinLength,
      ValidationMessage.mustMatch: (e) => AppString.mustMatch,
      ValidationMessage.max: (e) =>
          "${AppString.valueMustBeSmallerThan} ${maxValue ?? 0}",
      ValidationMessage.min: (e) =>
          "${AppString.valueMustBeLargerThan} ${minValue ?? 0}",
    };
  }
}
