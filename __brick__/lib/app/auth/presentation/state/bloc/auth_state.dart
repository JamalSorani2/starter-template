part of 'auth_bloc.dart';

class AuthState {
  Result<LoginAuthModel> loginAuthState;
  Result<SignUpAuthModel> signUpAuthState;
  Result<ChangePasswordAuthModel> changePasswordAuthState;
  Result<ForgotPasswordAuthModel> forgotPasswordAuthState;
  Result<VerifyForgotPasswordCodeAuthModel> verifyForgotPasswordCodeAuthState;
  Result<SetNewPasswordAuthModel> setNewPasswordAuthState;
  Result<RequestConfirmPhoneNumberAuthModel> requestConfirmPhoneNumberAuthState;
  Result<ConfirmPhoneNumberAuthModel> confirmPhoneNumberAuthState;
  Result<UpdatePhoneNumberAuthModel> updatePhoneNumberAuthState;
  Result<AuthConfirmPhoneNumberModel> authConfirmPhoneNumberState;
  Result<RequestConfirmEmailAuthModel> requestConfirmEmailAuthState;
  Result<ConfirmEmailAuthModel> confirmEmailAuthState;
  Result<SetupGoogleAuthenticatorModel> setupGoogleAuthenticatorState;
  Result<ResendEmailTokenAuthModel> resendEmailTokenAuthState;
  Result<ResendPhoneNumberCodeAuthModel> resendPhoneNumberCodeAuthState;
  Result<LogoutAuthModel> logoutAuthState;
  Result<RefreshTokenAuthModel> refreshTokenAuthState;

  AuthState({
    this.loginAuthState = const Result.init(),
    this.signUpAuthState = const Result.init(),
    this.changePasswordAuthState = const Result.init(),
    this.forgotPasswordAuthState = const Result.init(),
    this.verifyForgotPasswordCodeAuthState = const Result.init(),
    this.setNewPasswordAuthState = const Result.init(),
    this.requestConfirmPhoneNumberAuthState = const Result.init(),
    this.confirmPhoneNumberAuthState = const Result.init(),
    this.updatePhoneNumberAuthState = const Result.init(),
    this.authConfirmPhoneNumberState = const Result.init(),
    this.requestConfirmEmailAuthState = const Result.init(),
    this.confirmEmailAuthState = const Result.init(),
    this.setupGoogleAuthenticatorState = const Result.init(),
    this.resendEmailTokenAuthState = const Result.init(),
    this.resendPhoneNumberCodeAuthState = const Result.init(),
    this.logoutAuthState = const Result.init(),
    this.refreshTokenAuthState = const Result.init(),
  });

  AuthState copyWith({
    Result<LoginAuthModel>? loginAuthState,
    Result<SignUpAuthModel>? signUpAuthState,
    Result<ChangePasswordAuthModel>? changePasswordAuthState,
    Result<ForgotPasswordAuthModel>? forgotPasswordAuthState,
    Result<VerifyForgotPasswordCodeAuthModel>? verifyForgotPasswordCodeAuthState,
    Result<SetNewPasswordAuthModel>? setNewPasswordAuthState,
    Result<RequestConfirmPhoneNumberAuthModel>? requestConfirmPhoneNumberAuthState,
    Result<ConfirmPhoneNumberAuthModel>? confirmPhoneNumberAuthState,
    Result<UpdatePhoneNumberAuthModel>? updatePhoneNumberAuthState,
    Result<AuthConfirmPhoneNumberModel>? authConfirmPhoneNumberState,
    Result<RequestConfirmEmailAuthModel>? requestConfirmEmailAuthState,
    Result<ConfirmEmailAuthModel>? confirmEmailAuthState,
    Result<SetupGoogleAuthenticatorModel>? setupGoogleAuthenticatorState,
    Result<ResendEmailTokenAuthModel>? resendEmailTokenAuthState,
    Result<ResendPhoneNumberCodeAuthModel>? resendPhoneNumberCodeAuthState,
    Result<LogoutAuthModel>? logoutAuthState,
    Result<RefreshTokenAuthModel>? refreshTokenAuthState,
  }) {
    return AuthState(
      loginAuthState: loginAuthState ?? this.loginAuthState,
      signUpAuthState: signUpAuthState ?? this.signUpAuthState,
      changePasswordAuthState: changePasswordAuthState ?? this.changePasswordAuthState,
      forgotPasswordAuthState: forgotPasswordAuthState ?? this.forgotPasswordAuthState,
      verifyForgotPasswordCodeAuthState: verifyForgotPasswordCodeAuthState ?? this.verifyForgotPasswordCodeAuthState,
      setNewPasswordAuthState: setNewPasswordAuthState ?? this.setNewPasswordAuthState,
      requestConfirmPhoneNumberAuthState: requestConfirmPhoneNumberAuthState ?? this.requestConfirmPhoneNumberAuthState,
      confirmPhoneNumberAuthState: confirmPhoneNumberAuthState ?? this.confirmPhoneNumberAuthState,
      updatePhoneNumberAuthState: updatePhoneNumberAuthState ?? this.updatePhoneNumberAuthState,
      authConfirmPhoneNumberState: authConfirmPhoneNumberState ?? this.authConfirmPhoneNumberState,
      requestConfirmEmailAuthState: requestConfirmEmailAuthState ?? this.requestConfirmEmailAuthState,
      confirmEmailAuthState: confirmEmailAuthState ?? this.confirmEmailAuthState,
      setupGoogleAuthenticatorState: setupGoogleAuthenticatorState ?? this.setupGoogleAuthenticatorState,
      resendEmailTokenAuthState: resendEmailTokenAuthState ?? this.resendEmailTokenAuthState,
      resendPhoneNumberCodeAuthState: resendPhoneNumberCodeAuthState ?? this.resendPhoneNumberCodeAuthState,
      logoutAuthState: logoutAuthState ?? this.logoutAuthState,
      refreshTokenAuthState: refreshTokenAuthState ?? this.refreshTokenAuthState,
    );
  }
}
