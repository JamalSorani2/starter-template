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
import '../models/sign_up_auth_model.dart';
import '../models/change_password_auth_model.dart';
import '../models/forgot_password_auth_model.dart';
import '../models/verify_forgot_password_code_auth_model.dart';
import '../models/set_new_password_auth_model.dart';
import '../models/request_confirm_phone_number_auth_model.dart';
import '../models/confirm_phone_number_auth_model.dart';
import '../models/update_phone_number_auth_model.dart';
import '../models/auth_confirm_phone_number_model.dart';
import '../models/request_confirm_email_auth_model.dart';
import '../models/confirm_email_auth_model.dart';
import '../models/setup_google_authenticator_model.dart';
import '../models/resend_email_token_auth_model.dart';
import '../models/resend_phone_number_code_auth_model.dart';
import '../models/logout_auth_model.dart';
import '../models/refresh_token_auth_model.dart';
import '../../domain/entities/login_auth_param.dart';
import '../../domain/entities/sign_up_auth_param.dart';
import '../../domain/entities/change_password_auth_param.dart';
import '../../domain/entities/forgot_password_auth_param.dart';
import '../../domain/entities/verify_forgot_password_code_auth_param.dart';
import '../../domain/entities/set_new_password_auth_param.dart';
import '../../domain/entities/request_confirm_phone_number_auth_param.dart';
import '../../domain/entities/confirm_phone_number_auth_param.dart';
import '../../domain/entities/update_phone_number_auth_param.dart';
import '../../domain/entities/auth_confirm_phone_number_param.dart';
import '../../domain/entities/request_confirm_email_auth_param.dart';
import '../../domain/entities/confirm_email_auth_param.dart';
import '../../domain/entities/setup_google_authenticator_param.dart';
import '../../domain/entities/resend_email_token_auth_param.dart';
import '../../domain/entities/resend_phone_number_code_auth_param.dart';
import '../../domain/entities/logout_auth_param.dart';
import '../../domain/entities/refresh_token_auth_param.dart';

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
  Future<Either<Failure, SignUpAuthModel>> signUpAuth({
    required SignUpAuthParam signUpAuthParam,
  }) {
    return throwAppException(() async {
      final response = await _remote.signUpAuth(
        signUpAuthParam: signUpAuthParam,
      );
      return response;
    });
  }

  @override
  Future<Either<Failure, ChangePasswordAuthModel>> changePasswordAuth({
    required ChangePasswordAuthParam changePasswordAuthParam,
  }) {
    return throwAppException(() async {
      final response = await _remote.changePasswordAuth(
        changePasswordAuthParam: changePasswordAuthParam,
      );
      return response;
    });
  }

  @override
  Future<Either<Failure, ForgotPasswordAuthModel>> forgotPasswordAuth({
    required ForgotPasswordAuthParam forgotPasswordAuthParam,
  }) {
    return throwAppException(() async {
      final response = await _remote.forgotPasswordAuth(
        forgotPasswordAuthParam: forgotPasswordAuthParam,
      );
      return response;
    });
  }

  @override
  Future<Either<Failure, VerifyForgotPasswordCodeAuthModel>>
      verifyForgotPasswordCodeAuth({
    required VerifyForgotPasswordCodeAuthParam
        verifyForgotPasswordCodeAuthParam,
  }) {
    return throwAppException(() async {
      final response = await _remote.verifyForgotPasswordCodeAuth(
        verifyForgotPasswordCodeAuthParam: verifyForgotPasswordCodeAuthParam,
      );
      return response;
    });
  }

  @override
  Future<Either<Failure, SetNewPasswordAuthModel>> setNewPasswordAuth({
    required SetNewPasswordAuthParam setNewPasswordAuthParam,
  }) {
    return throwAppException(() async {
      final response = await _remote.setNewPasswordAuth(
        setNewPasswordAuthParam: setNewPasswordAuthParam,
      );
      return response;
    });
  }

  @override
  Future<Either<Failure, RequestConfirmPhoneNumberAuthModel>>
      requestConfirmPhoneNumberAuth({
    required RequestConfirmPhoneNumberAuthParam
        requestConfirmPhoneNumberAuthParam,
  }) {
    return throwAppException(() async {
      final response = await _remote.requestConfirmPhoneNumberAuth(
        requestConfirmPhoneNumberAuthParam: requestConfirmPhoneNumberAuthParam,
      );
      return response;
    });
  }

  @override
  Future<Either<Failure, ConfirmPhoneNumberAuthModel>> confirmPhoneNumberAuth({
    required ConfirmPhoneNumberAuthParam confirmPhoneNumberAuthParam,
  }) {
    return throwAppException(() async {
      final response = await _remote.confirmPhoneNumberAuth(
        confirmPhoneNumberAuthParam: confirmPhoneNumberAuthParam,
      );
      return response;
    });
  }

  @override
  Future<Either<Failure, UpdatePhoneNumberAuthModel>> updatePhoneNumberAuth({
    required UpdatePhoneNumberAuthParam updatePhoneNumberAuthParam,
  }) {
    return throwAppException(() async {
      final response = await _remote.updatePhoneNumberAuth(
        updatePhoneNumberAuthParam: updatePhoneNumberAuthParam,
      );
      return response;
    });
  }

  @override
  Future<Either<Failure, AuthConfirmPhoneNumberModel>> authConfirmPhoneNumber({
    required AuthConfirmPhoneNumberParam authConfirmPhoneNumberParam,
  }) {
    return throwAppException(() async {
      final response = await _remote.authConfirmPhoneNumber(
        authConfirmPhoneNumberParam: authConfirmPhoneNumberParam,
      );
      return response;
    });
  }

  @override
  Future<Either<Failure, RequestConfirmEmailAuthModel>>
      requestConfirmEmailAuth({
    required RequestConfirmEmailAuthParam requestConfirmEmailAuthParam,
  }) {
    return throwAppException(() async {
      final response = await _remote.requestConfirmEmailAuth(
        requestConfirmEmailAuthParam: requestConfirmEmailAuthParam,
      );
      return response;
    });
  }

  @override
  Future<Either<Failure, ConfirmEmailAuthModel>> confirmEmailAuth({
    required ConfirmEmailAuthParam confirmEmailAuthParam,
  }) {
    return throwAppException(() async {
      final response = await _remote.confirmEmailAuth(
        confirmEmailAuthParam: confirmEmailAuthParam,
      );
      return response;
    });
  }

  @override
  Future<Either<Failure, SetupGoogleAuthenticatorModel>>
      setupGoogleAuthenticator({
    required SetupGoogleAuthenticatorParam setupGoogleAuthenticatorParam,
  }) {
    return throwAppException(() async {
      final response = await _remote.setupGoogleAuthenticator(
        setupGoogleAuthenticatorParam: setupGoogleAuthenticatorParam,
      );
      return response;
    });
  }

  @override
  Future<Either<Failure, ResendEmailTokenAuthModel>> resendEmailTokenAuth({
    required ResendEmailTokenAuthParam resendEmailTokenAuthParam,
  }) {
    return throwAppException(() async {
      final response = await _remote.resendEmailTokenAuth(
        resendEmailTokenAuthParam: resendEmailTokenAuthParam,
      );
      return response;
    });
  }

  @override
  Future<Either<Failure, ResendPhoneNumberCodeAuthModel>>
      resendPhoneNumberCodeAuth({
    required ResendPhoneNumberCodeAuthParam resendPhoneNumberCodeAuthParam,
  }) {
    return throwAppException(() async {
      final response = await _remote.resendPhoneNumberCodeAuth(
        resendPhoneNumberCodeAuthParam: resendPhoneNumberCodeAuthParam,
      );
      return response;
    });
  }

  @override
  Future<Either<Failure, LogoutAuthModel>> logoutAuth({
    required LogoutAuthParam logoutAuthParam,
  }) {
    return throwAppException(() async {
      final response = await _remote.logoutAuth(
        logoutAuthParam: logoutAuthParam,
      );
      return response;
    });
  }

  @override
  Future<Either<Failure, RefreshTokenAuthModel>> refreshTokenAuth({
    required RefreshTokenAuthParam refreshTokenAuthParam,
  }) {
    return throwAppException(() async {
      final response = await _remote.refreshTokenAuth(
        refreshTokenAuthParam: refreshTokenAuthParam,
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
    await NotificationService.logout(userId: userId);
    await getIt<StorageService<SecureStorage>>().removeUser();
    await getIt<ReactiveTokenStorage>().delete();
    await getIt<FlutterSecureStorage>().deleteAll();
    await getIt<ReactiveTokenStorage>().loadToken();
    await getIt<StorageService>().clear();
    await getIt<StorageService>().setString(KUserLanguage, language ?? "ar");
    await getIt<SharedPreferences>().setBool(KOnboardingCompleted, false);
  }
}
