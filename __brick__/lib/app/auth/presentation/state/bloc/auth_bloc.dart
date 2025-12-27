import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common/presentaion/ui/widget/state/result_builder/result.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../../data/models/login_auth_model.dart';
import '../../../data/models/sign_up_auth_model.dart';
import '../../../data/models/change_password_auth_model.dart';
import '../../../data/models/forgot_password_auth_model.dart';
import '../../../data/models/verify_forgot_password_code_auth_model.dart';
import '../../../data/models/set_new_password_auth_model.dart';
import '../../../data/models/request_confirm_phone_number_auth_model.dart';
import '../../../data/models/confirm_phone_number_auth_model.dart';
import '../../../data/models/update_phone_number_auth_model.dart';
import '../../../data/models/auth_confirm_phone_number_model.dart';
import '../../../data/models/request_confirm_email_auth_model.dart';
import '../../../data/models/confirm_email_auth_model.dart';
import '../../../data/models/setup_google_authenticator_model.dart';
import '../../../data/models/resend_email_token_auth_model.dart';
import '../../../data/models/resend_phone_number_code_auth_model.dart';
import '../../../data/models/logout_auth_model.dart';
import '../../../data/models/refresh_token_auth_model.dart';
import '../../../domain/entities/login_auth_param.dart';
import '../../../domain/entities/sign_up_auth_param.dart';
import '../../../domain/entities/change_password_auth_param.dart';
import '../../../domain/entities/forgot_password_auth_param.dart';
import '../../../domain/entities/verify_forgot_password_code_auth_param.dart';
import '../../../domain/entities/set_new_password_auth_param.dart';
import '../../../domain/entities/request_confirm_phone_number_auth_param.dart';
import '../../../domain/entities/confirm_phone_number_auth_param.dart';
import '../../../domain/entities/update_phone_number_auth_param.dart';
import '../../../domain/entities/auth_confirm_phone_number_param.dart';
import '../../../domain/entities/request_confirm_email_auth_param.dart';
import '../../../domain/entities/confirm_email_auth_param.dart';
import '../../../domain/entities/setup_google_authenticator_param.dart';
import '../../../domain/entities/resend_email_token_auth_param.dart';
import '../../../domain/entities/resend_phone_number_code_auth_param.dart';
import '../../../domain/entities/logout_auth_param.dart';
import '../../../domain/entities/refresh_token_auth_param.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;
  AuthBloc({required AuthRepository repository})
      : _repository = repository,
        super(AuthState()) {
    on<LoginAuthEvent>(_loginAuth);
    on<SignUpAuthEvent>(_signUpAuth);
    on<ChangePasswordAuthEvent>(_changePasswordAuth);
    on<ForgotPasswordAuthEvent>(_forgotPasswordAuth);
    on<VerifyForgotPasswordCodeAuthEvent>(_verifyForgotPasswordCodeAuth);
    on<SetNewPasswordAuthEvent>(_setNewPasswordAuth);
    on<RequestConfirmPhoneNumberAuthEvent>(_requestConfirmPhoneNumberAuth);
    on<ConfirmPhoneNumberAuthEvent>(_confirmPhoneNumberAuth);
    on<UpdatePhoneNumberAuthEvent>(_updatePhoneNumberAuth);
    on<AuthConfirmPhoneNumberEvent>(_authConfirmPhoneNumber);
    on<RequestConfirmEmailAuthEvent>(_requestConfirmEmailAuth);
    on<ConfirmEmailAuthEvent>(_confirmEmailAuth);
    on<SetupGoogleAuthenticatorEvent>(_setupGoogleAuthenticator);
    on<ResendEmailTokenAuthEvent>(_resendEmailTokenAuth);
    on<ResendPhoneNumberCodeAuthEvent>(_resendPhoneNumberCodeAuth);
    on<LogoutAuthEvent>(_logoutAuth);
    on<RefreshTokenAuthEvent>(_refreshTokenAuth);
  }

  /// Handles the [LoginAuthEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _loginAuth(LoginAuthEvent event, Emitter emit) async {
    emit(state.copyWith(loginAuthState: const Result.loading()));
    final response =
        await _repository.loginAuth(loginAuthParam: event.loginAuthParam);
    response.fold(
      (l) => emit(state.copyWith(loginAuthState: Result.error(error: l))),
      (r) => emit(state.copyWith(loginAuthState: Result.loaded(data: r))),
    );
  }

  /// Handles the [SignUpAuthEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _signUpAuth(SignUpAuthEvent event, Emitter emit) async {
    emit(state.copyWith(signUpAuthState: const Result.loading()));
    final response =
        await _repository.signUpAuth(signUpAuthParam: event.signUpAuthParam);
    response.fold(
      (l) => emit(state.copyWith(signUpAuthState: Result.error(error: l))),
      (r) => emit(state.copyWith(signUpAuthState: Result.loaded(data: r))),
    );
  }

  /// Handles the [ChangePasswordAuthEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _changePasswordAuth(
    ChangePasswordAuthEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(changePasswordAuthState: const Result.loading()));
    final response = await _repository.changePasswordAuth(
      changePasswordAuthParam: event.changePasswordAuthParam,
    );
    response.fold(
      (l) =>
          emit(state.copyWith(changePasswordAuthState: Result.error(error: l))),
      (r) =>
          emit(state.copyWith(changePasswordAuthState: Result.loaded(data: r))),
    );
  }

  /// Handles the [ForgotPasswordAuthEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _forgotPasswordAuth(
    ForgotPasswordAuthEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(forgotPasswordAuthState: const Result.loading()));
    final response = await _repository.forgotPasswordAuth(
      forgotPasswordAuthParam: event.forgotPasswordAuthParam,
    );
    response.fold(
      (l) =>
          emit(state.copyWith(forgotPasswordAuthState: Result.error(error: l))),
      (r) =>
          emit(state.copyWith(forgotPasswordAuthState: Result.loaded(data: r))),
    );
  }

  /// Handles the [VerifyForgotPasswordCodeAuthEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _verifyForgotPasswordCodeAuth(
    VerifyForgotPasswordCodeAuthEvent event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(
        verifyForgotPasswordCodeAuthState: const Result.loading(),
      ),
    );
    final response = await _repository.verifyForgotPasswordCodeAuth(
      verifyForgotPasswordCodeAuthParam:
          event.verifyForgotPasswordCodeAuthParam,
    );
    response.fold(
      (l) => emit(
        state.copyWith(
          verifyForgotPasswordCodeAuthState: Result.error(error: l),
        ),
      ),
      (r) => emit(
        state.copyWith(
          verifyForgotPasswordCodeAuthState: Result.loaded(data: r),
        ),
      ),
    );
  }

  /// Handles the [SetNewPasswordAuthEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _setNewPasswordAuth(
    SetNewPasswordAuthEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(setNewPasswordAuthState: const Result.loading()));
    final response = await _repository.setNewPasswordAuth(
      setNewPasswordAuthParam: event.setNewPasswordAuthParam,
    );
    response.fold(
      (l) =>
          emit(state.copyWith(setNewPasswordAuthState: Result.error(error: l))),
      (r) =>
          emit(state.copyWith(setNewPasswordAuthState: Result.loaded(data: r))),
    );
  }

  /// Handles the [RequestConfirmPhoneNumberAuthEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _requestConfirmPhoneNumberAuth(
    RequestConfirmPhoneNumberAuthEvent event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(
        requestConfirmPhoneNumberAuthState: const Result.loading(),
      ),
    );
    final response = await _repository.requestConfirmPhoneNumberAuth(
      requestConfirmPhoneNumberAuthParam:
          event.requestConfirmPhoneNumberAuthParam,
    );
    response.fold(
      (l) => emit(
        state.copyWith(
          requestConfirmPhoneNumberAuthState: Result.error(error: l),
        ),
      ),
      (r) => emit(
        state.copyWith(
          requestConfirmPhoneNumberAuthState: Result.loaded(data: r),
        ),
      ),
    );
  }

  /// Handles the [ConfirmPhoneNumberAuthEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _confirmPhoneNumberAuth(
    ConfirmPhoneNumberAuthEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(confirmPhoneNumberAuthState: const Result.loading()));
    final response = await _repository.confirmPhoneNumberAuth(
      confirmPhoneNumberAuthParam: event.confirmPhoneNumberAuthParam,
    );
    response.fold(
      (l) => emit(
        state.copyWith(confirmPhoneNumberAuthState: Result.error(error: l)),
      ),
      (r) => emit(
        state.copyWith(confirmPhoneNumberAuthState: Result.loaded(data: r)),
      ),
    );
  }

  /// Handles the [UpdatePhoneNumberAuthEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _updatePhoneNumberAuth(
    UpdatePhoneNumberAuthEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(updatePhoneNumberAuthState: const Result.loading()));
    final response = await _repository.updatePhoneNumberAuth(
      updatePhoneNumberAuthParam: event.updatePhoneNumberAuthParam,
    );
    response.fold(
      (l) => emit(
        state.copyWith(updatePhoneNumberAuthState: Result.error(error: l)),
      ),
      (r) => emit(
        state.copyWith(updatePhoneNumberAuthState: Result.loaded(data: r)),
      ),
    );
  }

  /// Handles the [AuthConfirmPhoneNumberEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _authConfirmPhoneNumber(
    AuthConfirmPhoneNumberEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(authConfirmPhoneNumberState: const Result.loading()));
    final response = await _repository.authConfirmPhoneNumber(
      authConfirmPhoneNumberParam: event.authConfirmPhoneNumberParam,
    );
    response.fold(
      (l) => emit(
        state.copyWith(authConfirmPhoneNumberState: Result.error(error: l)),
      ),
      (r) => emit(
        state.copyWith(authConfirmPhoneNumberState: Result.loaded(data: r)),
      ),
    );
  }

  /// Handles the [RequestConfirmEmailAuthEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _requestConfirmEmailAuth(
    RequestConfirmEmailAuthEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(requestConfirmEmailAuthState: const Result.loading()));
    final response = await _repository.requestConfirmEmailAuth(
      requestConfirmEmailAuthParam: event.requestConfirmEmailAuthParam,
    );
    response.fold(
      (l) => emit(
        state.copyWith(requestConfirmEmailAuthState: Result.error(error: l)),
      ),
      (r) => emit(
        state.copyWith(requestConfirmEmailAuthState: Result.loaded(data: r)),
      ),
    );
  }

  /// Handles the [ConfirmEmailAuthEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _confirmEmailAuth(
    ConfirmEmailAuthEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(confirmEmailAuthState: const Result.loading()));
    final response = await _repository.confirmEmailAuth(
      confirmEmailAuthParam: event.confirmEmailAuthParam,
    );
    response.fold(
      (l) =>
          emit(state.copyWith(confirmEmailAuthState: Result.error(error: l))),
      (r) =>
          emit(state.copyWith(confirmEmailAuthState: Result.loaded(data: r))),
    );
  }

  /// Handles the [SetupGoogleAuthenticatorEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _setupGoogleAuthenticator(
    SetupGoogleAuthenticatorEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(setupGoogleAuthenticatorState: const Result.loading()));
    final response = await _repository.setupGoogleAuthenticator(
      setupGoogleAuthenticatorParam: event.setupGoogleAuthenticatorParam,
    );
    response.fold(
      (l) => emit(
        state.copyWith(
          setupGoogleAuthenticatorState: Result.error(error: l),
        ),
      ),
      (r) => emit(
        state.copyWith(
          setupGoogleAuthenticatorState: Result.loaded(data: r),
        ),
      ),
    );
  }

  /// Handles the [ResendEmailTokenAuthEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _resendEmailTokenAuth(
    ResendEmailTokenAuthEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(resendEmailTokenAuthState: const Result.loading()));
    final response = await _repository.resendEmailTokenAuth(
      resendEmailTokenAuthParam: event.resendEmailTokenAuthParam,
    );
    response.fold(
      (l) => emit(
        state.copyWith(resendEmailTokenAuthState: Result.error(error: l)),
      ),
      (r) => emit(
        state.copyWith(resendEmailTokenAuthState: Result.loaded(data: r)),
      ),
    );
  }

  /// Handles the [ResendPhoneNumberCodeAuthEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _resendPhoneNumberCodeAuth(
    ResendPhoneNumberCodeAuthEvent event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(resendPhoneNumberCodeAuthState: const Result.loading()),
    );
    final response = await _repository.resendPhoneNumberCodeAuth(
      resendPhoneNumberCodeAuthParam: event.resendPhoneNumberCodeAuthParam,
    );
    response.fold(
      (l) => emit(
        state.copyWith(
          resendPhoneNumberCodeAuthState: Result.error(error: l),
        ),
      ),
      (r) => emit(
        state.copyWith(
          resendPhoneNumberCodeAuthState: Result.loaded(data: r),
        ),
      ),
    );
  }

  /// Handles the [LogoutAuthEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _logoutAuth(LogoutAuthEvent event, Emitter emit) async {
    emit(state.copyWith(logoutAuthState: const Result.loading()));
    final response =
        await _repository.logoutAuth(logoutAuthParam: event.logoutAuthParam);
    response.fold(
      (l) => emit(state.copyWith(logoutAuthState: Result.error(error: l))),
      (r) => emit(state.copyWith(logoutAuthState: Result.loaded(data: r))),
    );
  }

  /// Handles the [RefreshTokenAuthEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _refreshTokenAuth(
    RefreshTokenAuthEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(refreshTokenAuthState: const Result.loading()));
    final response = await _repository.refreshTokenAuth(
      refreshTokenAuthParam: event.refreshTokenAuthParam,
    );
    response.fold(
      (l) =>
          emit(state.copyWith(refreshTokenAuthState: Result.error(error: l))),
      (r) =>
          emit(state.copyWith(refreshTokenAuthState: Result.loaded(data: r))),
    );
  }
}
