class LoginAuthModel {
  final String token;
  final String refreshToken;
  LoginAuthModel({required this.token, required this.refreshToken});
  factory LoginAuthModel.fromJson(dynamic) {
    return LoginAuthModel(token: '', refreshToken: '');
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  LoginAuthModel copyWith({
    String? token,
    String? refreshToken,
  }) {
    return LoginAuthModel(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
