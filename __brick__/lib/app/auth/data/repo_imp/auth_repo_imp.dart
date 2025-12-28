import 'package:app_name/common/services/notification_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../../common/imports/imports.dart';
import '../../../../common/network/exception/failure.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_remote.dart';
import '../../../../common/network/exception/error_handler.dart';
import '../models/login_auth_model.dart';
import '../../domain/entities/login_auth_param.dart';

class AuthRepoImp implements AuthRepository {
  final AuthRemote _remote;
  final ReactiveTokenStorage reactiveTokenStorage;
  final internetConnectionChecker = InternetConnectionChecker.createInstance();

  AuthRepoImp({
    required AuthRemote remote,
    required this.reactiveTokenStorage,
  }) : _remote = remote;

  @override
  Future<Either<Failure, LoginAuthModel>> loginAuth({
    required LoginAuthParam loginAuthParam,
  }) {
    return throwAppException(() async {
      if (!(await internetConnectionChecker.hasConnection)) {
        return Left(Failure(message: "No Internet Connection", statusCode: ""));
      }
      final response = await _remote.loginAuth(
        loginAuthParam: loginAuthParam,
      );
      return response;
    });
  }

  @override
  Stream<AuthStatus> get authStatusStream =>
      reactiveTokenStorage.authenticationStatus;

  @override
  void logout() async {
    final String? language =
        await getIt<SharedPreferences>().getString(KUserLanguage);
    final user = await getIt<StorageService<SecureStorage>>().getUser();
    final userId = user?.userId;
    await getIt<NotificationService>().logout(userId: userId);
    await getIt<StorageService<SecureStorage>>().removeUser();
    await getIt<ReactiveTokenStorage>().delete();
    await getIt<FlutterSecureStorage>().deleteAll();
    await getIt<ReactiveTokenStorage>().loadToken();
    await getIt<StorageService>().clear();
    await getIt<StorageService>().setString(KUserLanguage, language ?? "ar");
    await getIt<SharedPreferences>().setBool(KOnboardingCompleted, false);
  }
}
