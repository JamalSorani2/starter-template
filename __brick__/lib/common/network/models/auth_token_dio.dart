import 'package:dio_refresh_bot/dio_refresh_bot.dart';

class AuthTokenModel extends AuthToken {
  const AuthTokenModel({required super.accessToken, super.refreshToken});

  @override
  Map<String, dynamic> toMap() {
    return {
      'token': accessToken,
      'refreshToken': refreshToken,
      'tokenType': refreshToken,
    };
  }

  factory AuthTokenModel.fromMap(Map<String, dynamic> data) {
    return AuthTokenModel(
      accessToken: data['token'],
      refreshToken: data['refreshToken'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthTokenModel &&
          runtimeType == other.runtimeType &&
          accessToken == other.accessToken &&
          refreshToken == other.refreshToken &&
          tokenType == other.tokenType;

  @override
  int get hashCode => accessToken.hashCode;
}
