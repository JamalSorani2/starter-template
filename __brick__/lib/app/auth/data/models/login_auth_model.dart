class LoginAuthModel {
  final String token;
  final String refreshToken;
  final String userId;
  LoginAuthModel({
    required this.token,
    required this.refreshToken,
    required this.userId,
  });
  factory LoginAuthModel.fromJson(dynamic) {
    return LoginAuthModel(token: '', refreshToken: '', userId: '');
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  LoginAuthModel copyWith({
    String? token,
    String? refreshToken,
    String? userId,
  }) {
    return LoginAuthModel(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      userId: userId ?? this.userId,
    );
  }
}
