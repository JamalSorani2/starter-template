class VerifyForgotPasswordCodeAuthParam {
  final String? code;
  final String? email;

  VerifyForgotPasswordCodeAuthParam({
    this.code,
    this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'email': email,
    }..removeWhere((key, value) => value == null);
  }
}
