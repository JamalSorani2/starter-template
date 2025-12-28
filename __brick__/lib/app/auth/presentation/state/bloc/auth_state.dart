part of 'auth_bloc.dart';

class AuthState {
  Result<LoginAuthModel> loginAuthState;

  AuthState({
    this.loginAuthState = const Result.init(),
  });

  AuthState copyWith({
    Result<LoginAuthModel>? loginAuthState,
  }) {
    return AuthState(
      loginAuthState: loginAuthState ?? this.loginAuthState,
    );
  }
}
