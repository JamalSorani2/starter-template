import 'package:dio/dio.dart';
import '../../../url.dart';
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

class AuthRemote {
  final Dio _dio;
  const AuthRemote(Dio dio) : _dio = dio;
  Future<LoginAuthModel> loginAuth({
    required LoginAuthParam loginAuthParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.loginAuth,
        data: loginAuthParam.toJson(),
      );
      return LoginAuthModel.fromJson(response.data);
    });
  }

  Future<SignUpAuthModel> signUpAuth({
    required SignUpAuthParam signUpAuthParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.signUpAuth,
        data: signUpAuthParam.toJson(),
      );
      return SignUpAuthModel.fromJson(response.data);
    });
  }

  Future<ChangePasswordAuthModel> changePasswordAuth({
    required ChangePasswordAuthParam changePasswordAuthParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.changePasswordAuth,
        data: changePasswordAuthParam.toJson(),
      );
      return ChangePasswordAuthModel.fromJson(response.data);
    });
  }

  Future<ForgotPasswordAuthModel> forgotPasswordAuth({
    required ForgotPasswordAuthParam forgotPasswordAuthParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.forgotPasswordAuth,
        data: forgotPasswordAuthParam.toJson(),
      );
      return ForgotPasswordAuthModel.fromJson(response.data);
    });
  }

  Future<VerifyForgotPasswordCodeAuthModel> verifyForgotPasswordCodeAuth({
    required VerifyForgotPasswordCodeAuthParam
        verifyForgotPasswordCodeAuthParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.verifyForgotPasswordCodeAuth,
        data: verifyForgotPasswordCodeAuthParam.toJson(),
      );
      return VerifyForgotPasswordCodeAuthModel.fromJson(response.data);
    });
  }

  Future<SetNewPasswordAuthModel> setNewPasswordAuth({
    required SetNewPasswordAuthParam setNewPasswordAuthParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.setNewPasswordAuth,
        data: setNewPasswordAuthParam.toJson(),
      );
      return SetNewPasswordAuthModel.fromJson(response.data);
    });
  }

  Future<RequestConfirmPhoneNumberAuthModel> requestConfirmPhoneNumberAuth({
    required RequestConfirmPhoneNumberAuthParam
        requestConfirmPhoneNumberAuthParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.requestConfirmPhoneNumberAuth,
        data: requestConfirmPhoneNumberAuthParam.toJson(),
      );
      return RequestConfirmPhoneNumberAuthModel.fromJson(response.data);
    });
  }

  Future<ConfirmPhoneNumberAuthModel> confirmPhoneNumberAuth({
    required ConfirmPhoneNumberAuthParam confirmPhoneNumberAuthParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.confirmPhoneNumberAuth,
        data: confirmPhoneNumberAuthParam.toJson(),
      );
      return ConfirmPhoneNumberAuthModel.fromJson(response.data);
    });
  }

  Future<UpdatePhoneNumberAuthModel> updatePhoneNumberAuth({
    required UpdatePhoneNumberAuthParam updatePhoneNumberAuthParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.updatePhoneNumberAuth,
        data: updatePhoneNumberAuthParam.toJson(),
      );
      return UpdatePhoneNumberAuthModel.fromJson(response.data);
    });
  }

  Future<AuthConfirmPhoneNumberModel> authConfirmPhoneNumber({
    required AuthConfirmPhoneNumberParam authConfirmPhoneNumberParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.authConfirmPhoneNumber,
        data: authConfirmPhoneNumberParam.toJson(),
      );
      return AuthConfirmPhoneNumberModel.fromJson(response.data);
    });
  }

  Future<RequestConfirmEmailAuthModel> requestConfirmEmailAuth({
    required RequestConfirmEmailAuthParam requestConfirmEmailAuthParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.requestConfirmEmailAuth,
        queryParameters: requestConfirmEmailAuthParam.toJson(),
      );
      return RequestConfirmEmailAuthModel.fromJson(response.data);
    });
  }

  Future<ConfirmEmailAuthModel> confirmEmailAuth({
    required ConfirmEmailAuthParam confirmEmailAuthParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.confirmEmailAuth,
        data: confirmEmailAuthParam.toJson(),
      );
      return ConfirmEmailAuthModel.fromJson(response.data);
    });
  }

  Future<SetupGoogleAuthenticatorModel> setupGoogleAuthenticator({
    required SetupGoogleAuthenticatorParam setupGoogleAuthenticatorParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.setupGoogleAuthenticator,
        data: setupGoogleAuthenticatorParam.toJson(),
      );
      return SetupGoogleAuthenticatorModel.fromJson(response.data);
    });
  }

  Future<ResendEmailTokenAuthModel> resendEmailTokenAuth({
    required ResendEmailTokenAuthParam resendEmailTokenAuthParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.resendEmailTokenAuth,
        data: resendEmailTokenAuthParam.toJson(),
      );
      return ResendEmailTokenAuthModel.fromJson(response.data);
    });
  }

  Future<ResendPhoneNumberCodeAuthModel> resendPhoneNumberCodeAuth({
    required ResendPhoneNumberCodeAuthParam resendPhoneNumberCodeAuthParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.resendPhoneNumberCodeAuth,
        data: resendPhoneNumberCodeAuthParam.toJson(),
      );
      return ResendPhoneNumberCodeAuthModel.fromJson(response.data);
    });
  }

  Future<LogoutAuthModel> logoutAuth({
    required LogoutAuthParam logoutAuthParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.delete(
        AppUrl.logoutAuth,
        data: logoutAuthParam.toJson(),
      );
      return LogoutAuthModel.fromJson(response.data);
    });
  }

  Future<RefreshTokenAuthModel> refreshTokenAuth({
    required RefreshTokenAuthParam refreshTokenAuthParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.refreshTokenAuth,
        data: refreshTokenAuthParam.toJson(),
      );
      return RefreshTokenAuthModel.fromJson(response.data);
    });
  }
}
