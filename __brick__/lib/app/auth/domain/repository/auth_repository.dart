import 'package:dartz/dartz.dart';
import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import '../../../../common/network/exception/failure.dart';
import '../../data/models/login_auth_model.dart';
import '../../data/models/sign_up_auth_model.dart';
import '../../data/models/change_password_auth_model.dart';
import '../../data/models/forgot_password_auth_model.dart';
import '../../data/models/verify_forgot_password_code_auth_model.dart';
import '../../data/models/set_new_password_auth_model.dart';
import '../../data/models/request_confirm_phone_number_auth_model.dart';
import '../../data/models/confirm_phone_number_auth_model.dart';
import '../../data/models/update_phone_number_auth_model.dart';
import '../../data/models/auth_confirm_phone_number_model.dart';
import '../../data/models/request_confirm_email_auth_model.dart';
import '../../data/models/confirm_email_auth_model.dart';
import '../../data/models/setup_google_authenticator_model.dart';
import '../../data/models/resend_email_token_auth_model.dart';
import '../../data/models/resend_phone_number_code_auth_model.dart';
import '../../data/models/logout_auth_model.dart';
import '../../data/models/refresh_token_auth_model.dart';
import '../entities/login_auth_param.dart';
import '../entities/sign_up_auth_param.dart';
import '../entities/change_password_auth_param.dart';
import '../entities/forgot_password_auth_param.dart';
import '../entities/verify_forgot_password_code_auth_param.dart';
import '../entities/set_new_password_auth_param.dart';
import '../entities/request_confirm_phone_number_auth_param.dart';
import '../entities/confirm_phone_number_auth_param.dart';
import '../entities/update_phone_number_auth_param.dart';
import '../entities/auth_confirm_phone_number_param.dart';
import '../entities/request_confirm_email_auth_param.dart';
import '../entities/confirm_email_auth_param.dart';
import '../entities/setup_google_authenticator_param.dart';
import '../entities/resend_email_token_auth_param.dart';
import '../entities/resend_phone_number_code_auth_param.dart';
import '../entities/logout_auth_param.dart';
import '../entities/refresh_token_auth_param.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginAuthModel>> loginAuth({
    required LoginAuthParam loginAuthParam,
  });
  Future<Either<Failure, SignUpAuthModel>> signUpAuth({
    required SignUpAuthParam signUpAuthParam,
  });
  Future<Either<Failure, ChangePasswordAuthModel>> changePasswordAuth({
    required ChangePasswordAuthParam changePasswordAuthParam,
  });
  Future<Either<Failure, ForgotPasswordAuthModel>> forgotPasswordAuth({
    required ForgotPasswordAuthParam forgotPasswordAuthParam,
  });
  Future<Either<Failure, VerifyForgotPasswordCodeAuthModel>>
      verifyForgotPasswordCodeAuth({
    required VerifyForgotPasswordCodeAuthParam
        verifyForgotPasswordCodeAuthParam,
  });
  Future<Either<Failure, SetNewPasswordAuthModel>> setNewPasswordAuth({
    required SetNewPasswordAuthParam setNewPasswordAuthParam,
  });
  Future<Either<Failure, RequestConfirmPhoneNumberAuthModel>>
      requestConfirmPhoneNumberAuth({
    required RequestConfirmPhoneNumberAuthParam
        requestConfirmPhoneNumberAuthParam,
  });
  Future<Either<Failure, ConfirmPhoneNumberAuthModel>> confirmPhoneNumberAuth({
    required ConfirmPhoneNumberAuthParam confirmPhoneNumberAuthParam,
  });
  Future<Either<Failure, UpdatePhoneNumberAuthModel>> updatePhoneNumberAuth({
    required UpdatePhoneNumberAuthParam updatePhoneNumberAuthParam,
  });
  Future<Either<Failure, AuthConfirmPhoneNumberModel>> authConfirmPhoneNumber({
    required AuthConfirmPhoneNumberParam authConfirmPhoneNumberParam,
  });
  Future<Either<Failure, RequestConfirmEmailAuthModel>>
      requestConfirmEmailAuth({
    required RequestConfirmEmailAuthParam requestConfirmEmailAuthParam,
  });
  Future<Either<Failure, ConfirmEmailAuthModel>> confirmEmailAuth({
    required ConfirmEmailAuthParam confirmEmailAuthParam,
  });
  Future<Either<Failure, SetupGoogleAuthenticatorModel>>
      setupGoogleAuthenticator({
    required SetupGoogleAuthenticatorParam setupGoogleAuthenticatorParam,
  });
  Future<Either<Failure, ResendEmailTokenAuthModel>> resendEmailTokenAuth({
    required ResendEmailTokenAuthParam resendEmailTokenAuthParam,
  });
  Future<Either<Failure, ResendPhoneNumberCodeAuthModel>>
      resendPhoneNumberCodeAuth({
    required ResendPhoneNumberCodeAuthParam resendPhoneNumberCodeAuthParam,
  });
  Future<Either<Failure, LogoutAuthModel>> logoutAuth({
    required LogoutAuthParam logoutAuthParam,
  });
  Future<Either<Failure, RefreshTokenAuthModel>> refreshTokenAuth({
    required RefreshTokenAuthParam refreshTokenAuthParam,
  });

  void logout();

  Stream<AuthStatus> get authStatusStream;
}
