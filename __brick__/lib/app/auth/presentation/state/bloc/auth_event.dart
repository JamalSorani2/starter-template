part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginAuthEvent extends AuthEvent {
  final LoginAuthParam loginAuthParam;

  LoginAuthEvent({required this.loginAuthParam});
}
