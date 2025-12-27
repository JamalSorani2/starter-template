import '../../translate/app_string.dart';

class AppException implements Exception {
  final String message;
  final String statusCode;
  final Exception innerException;

  AppException(this.message, this.statusCode, this.innerException);

  factory AppException.unknown() =>
      AppException(AppString.tryAgain, "", Exception());

  factory AppException.known(message, statusCode) =>
      AppException(message, statusCode, Exception());
}
