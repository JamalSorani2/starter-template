import 'dart:async';
import 'dart:developer';

import '../../imports/imports.dart';
import 'failure.dart';

/// ===============================
/// THROW APP EXCEPTION
/// ===============================
Future<Either<Failure, T>> throwAppException<T>(
  FutureOr<T> Function() call,
) async {
  try {
    final result = await call();
    return Right(result);
  } on AppException catch (e) {
    return Left(
      Failure(
        message: e.message,
        statusCode: e.statusCode,
      ),
    );
  } catch (e) {
    // log('Unhandled Exception: $e', stackTrace: s);

    return Left(
      Failure(
        message: AppString.somethingWentWrong,
        statusCode: "",
      ),
    );
  }
}

/// ===============================
/// THROW DIO EXCEPTION
/// ===============================
Future<T> throwDioException<T>(
  FutureOr<T> Function() call,
) async {
  try {
    return await call();
  } on DioException catch (e) {
    // log('DioException: ${e.message}', stackTrace: s);

    final statusCode = e.response?.statusCode?.toString() ?? "";

    String message = _extractErrorMessage(
      e.response?.data,
      e.message,
    );

    // Handle Dio types (timeout / connection / etc)
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = AppString.noInternetConnection;
        break;

      case DioExceptionType.connectionError:
        message = AppString.noInternetConnection;
        break;

      case DioExceptionType.badResponse:
        // keep extracted message
        break;

      default:
        message = message.isEmpty ? AppString.somethingWentWrong : message;
    }

    throw AppException.known(
      message,
      statusCode,
    );
  } catch (e, s) {
    log('Unknown Exception: $e', stackTrace: s);
    throw AppException.unknown();
  }
}

/// ===============================
/// ERROR MESSAGE EXTRACTOR
/// ===============================
String _extractErrorMessage(
  dynamic data,
  String? fallback,
) {
  try {
    if (data is Map<String, dynamic>) {
      // Case 1: errorMessage is Map
      if (data['errorMessage'] is Map<String, dynamic>) {
        return data['errorMessage']['message']?.toString() ??
            fallback ??
            AppString.serverError;
      }

      // Case 2: errorMessage is String
      if (data['errorMessage'] != null) {
        return data['errorMessage'].toString();
      }

      // Case 3: message field
      if (data['message'] != null) {
        return data['message'].toString();
      }

      // Case 4: title (ASP.NET style)
      if (data['title'] != null) {
        return data['title'].toString();
      }
    }

    return fallback ?? AppString.serverError;
  } catch (_) {
    return fallback ?? AppString.serverError;
  }
}
