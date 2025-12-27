class ForgotPasswordAuthParam {
  final String? email;

  ForgotPasswordAuthParam({
    this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    }..removeWhere((key, value) => value == null);
  }
}
