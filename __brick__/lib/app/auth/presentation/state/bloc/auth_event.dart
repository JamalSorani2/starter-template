part of 'auth_bloc.dart';
abstract class AuthEvent {}

class LoginAuthEvent extends AuthEvent {
  final LoginAuthParam loginAuthParam;

  LoginAuthEvent({required this.loginAuthParam});
}

class SignUpAuthEvent extends AuthEvent {
  final SignUpAuthParam signUpAuthParam;

  SignUpAuthEvent({required this.signUpAuthParam});
}

class ChangePasswordAuthEvent extends AuthEvent {
  final ChangePasswordAuthParam changePasswordAuthParam;

  ChangePasswordAuthEvent({required this.changePasswordAuthParam});
}

class ForgotPasswordAuthEvent extends AuthEvent {
  final ForgotPasswordAuthParam forgotPasswordAuthParam;

  ForgotPasswordAuthEvent({required this.forgotPasswordAuthParam});
}

class VerifyForgotPasswordCodeAuthEvent extends AuthEvent {
  final VerifyForgotPasswordCodeAuthParam verifyForgotPasswordCodeAuthParam;

  VerifyForgotPasswordCodeAuthEvent({required this.verifyForgotPasswordCodeAuthParam});
}

class SetNewPasswordAuthEvent extends AuthEvent {
  final SetNewPasswordAuthParam setNewPasswordAuthParam;

  SetNewPasswordAuthEvent({required this.setNewPasswordAuthParam});
}

class RequestConfirmPhoneNumberAuthEvent extends AuthEvent {
  final RequestConfirmPhoneNumberAuthParam requestConfirmPhoneNumberAuthParam;

  RequestConfirmPhoneNumberAuthEvent({required this.requestConfirmPhoneNumberAuthParam});
}

class ConfirmPhoneNumberAuthEvent extends AuthEvent {
  final ConfirmPhoneNumberAuthParam confirmPhoneNumberAuthParam;

  ConfirmPhoneNumberAuthEvent({required this.confirmPhoneNumberAuthParam});
}

class UpdatePhoneNumberAuthEvent extends AuthEvent {
  final UpdatePhoneNumberAuthParam updatePhoneNumberAuthParam;

  UpdatePhoneNumberAuthEvent({required this.updatePhoneNumberAuthParam});
}

class AuthConfirmPhoneNumberEvent extends AuthEvent {
  final AuthConfirmPhoneNumberParam authConfirmPhoneNumberParam;

  AuthConfirmPhoneNumberEvent({required this.authConfirmPhoneNumberParam});
}

class RequestConfirmEmailAuthEvent extends AuthEvent {
  final RequestConfirmEmailAuthParam requestConfirmEmailAuthParam;

  RequestConfirmEmailAuthEvent({required this.requestConfirmEmailAuthParam});
}

class ConfirmEmailAuthEvent extends AuthEvent {
  final ConfirmEmailAuthParam confirmEmailAuthParam;

  ConfirmEmailAuthEvent({required this.confirmEmailAuthParam});
}

class SetupGoogleAuthenticatorEvent extends AuthEvent {
  final SetupGoogleAuthenticatorParam setupGoogleAuthenticatorParam;

  SetupGoogleAuthenticatorEvent({required this.setupGoogleAuthenticatorParam});
}

class ResendEmailTokenAuthEvent extends AuthEvent {
  final ResendEmailTokenAuthParam resendEmailTokenAuthParam;

  ResendEmailTokenAuthEvent({required this.resendEmailTokenAuthParam});
}

class ResendPhoneNumberCodeAuthEvent extends AuthEvent {
  final ResendPhoneNumberCodeAuthParam resendPhoneNumberCodeAuthParam;

  ResendPhoneNumberCodeAuthEvent({required this.resendPhoneNumberCodeAuthParam});
}

class LogoutAuthEvent extends AuthEvent {
  final LogoutAuthParam logoutAuthParam;

  LogoutAuthEvent({required this.logoutAuthParam});
}

class RefreshTokenAuthEvent extends AuthEvent {
  final RefreshTokenAuthParam refreshTokenAuthParam;

  RefreshTokenAuthEvent({required this.refreshTokenAuthParam});
}

