import '../imports/imports.dart';

class ValidationHelper {
  static Map<String, String Function(Object)>? validationMessages(
      String? minLengthValidator,) {
    return {
      ValidationMessage.required: (e) => AppString.thisFieldRequired,
      ValidationMessage.email: (e) => AppString.validEmail,
      ValidationMessage.minLength: (e) =>
          minLengthValidator ?? AppString.passwordMinLength,
      ValidationMessage.mustMatch: (e) => AppString.mustMatch,
      'phoneNotValid': (e) => AppString.enterValidPhone,
    };
  }
}
