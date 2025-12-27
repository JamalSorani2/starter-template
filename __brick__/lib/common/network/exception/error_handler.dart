import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../imports/imports.dart';
import 'app_exception.dart';
import 'failure.dart';

Future<Either<Failure, U>> throwAppException<U>(
  FutureOr Function() call,
) async {
  try {
    return Right(await call());
  } on AppException catch (e) {
    // final message= e.message;
    return Left(
      Failure(
        message: e.statusCode == "500" &&
                e.message.toString().toLowerCase().contains('servererror')
            ? AppString.internalServerError
            : e.message,
        statusCode: e.statusCode,
      ),
    );
  } catch (e, s) {
    log(e.toString(), stackTrace: s);
    throw AppException.unknown();
  }
}

Future<T> throwDioException<T>(FutureOr<T> Function() call) async {
  try {
    return await call();
  } on DioException catch (e) {
    var message = e.response?.data is Map<String, dynamic>
        ? e.response?.data['errorMessage'] ??
            e.response?.data['message'] ??
            e.message ??
            AppString.serverError
        : e.message ?? AppString.serverError;
    if (message.toString().contains(
          "This exception was thrown because the response has a status code",
        )) {
      message = AppString.somethingWentWrong;
    } else if (message.toString().contains("connection error")) {
      message = AppString.noInternetConnection;
    }
    throw AppException.known(message, e.response?.statusCode.toString() ?? "");
  } catch (e, s) {
    log('Unknown Exception: $e', stackTrace: s);
    throw AppException.unknown();
  }
}
