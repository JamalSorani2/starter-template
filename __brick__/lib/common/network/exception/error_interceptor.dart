import '../../imports/imports.dart';

class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.error is SocketException) {
      err = err.copyWith(
        error: AppException.known(
          AppString.noInternetConnection,
          err.response?.statusCode.toString() ?? "",
        ),
      );
      handler.reject(err);
      return;
    }

    final responseData = err.response?.data;
    if (err.response?.statusCode == 500) {
      err = err.copyWith(
        error: AppException.known(AppString.internalServerError, "500"),
        message: AppString.internalServerError,
      );
      handler.reject(err);
      return;
    } else if (err.response?.statusCode == 502) {
      err = err.copyWith(
        error: AppException.known(AppString.serverUpdates, "502"),
        message: AppString.serverUpdates,
      );
      handler.reject(err);
      return;
    } else if (err.response?.statusCode == 403) {
      err = err.copyWith(
        error: AppException.known(AppString.noPermission, "403"),
        message: AppString.noPermission,
      );
      handler.reject(err);
      return;
    }

    if (responseData != null &&
            responseData.isNotEmpty &&
            responseData is Map ||
        responseData is String) {
      String? message;
      String? errorMessage;

      try {
        errorMessage = responseData["message"]?.toString();
        if (responseData is Map && errorMessage != null) {
          message = errorMessage;
        } else if (responseData is String && responseData.isNotEmpty) {
          message = responseData;
        }
      } catch (_) {}

      if (message != null && message.isNotEmpty) {
        if (message.contains("connection error") ||
            message.contains("request connection took longer") ||
            message.contains("No Internet Connection")) {
          err = err.copyWith(
            error: AppException.known(
              AppString.noInternetConnection,
              err.response?.statusCode.toString() ?? "",
            ),
          );
        } else if (message.toLowerCase().contains("servererror")) {
          err = err.copyWith(
            error: AppException.known(
              AppString.internalServerError,
              err.response?.statusCode.toString() ?? "",
            ),
          );
        } else {
          err = err.copyWith(error: message);
        }
        handler.next(err);
        return;
      }
    }

    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      err = err.copyWith(
        error: AppException.known(
          AppString.noInternetConnection,
          err.response?.statusCode.toString() ?? "",
        ),
      );
      handler.next(err);
    } else if (err.type == DioExceptionType.badResponse &&
        err.response?.statusCode == 500) {
      err = err.copyWith(
        error: AppException.known(
          AppString.tryAgainLater,
          err.response?.statusCode.toString() ?? "",
        ),
      );
      handler.next(err);
    } else if (err.type == DioExceptionType.badResponse) {
      final data = err.response?.data;
      err = err.copyWith(
        error: data is String
            ? AppException.known(
                data,
                err.response?.statusCode.toString() ?? "",
              )
            : AppException.unknown(),
      );
      handler.next(err);
    } else {
      err = err.copyWith(error: AppException.unknown());
      handler.next(err);
    }
  }
}
