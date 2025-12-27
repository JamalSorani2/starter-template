class SetNewPasswordAuthParam {
  final String? email;
  final String? password;
  final String? confirmPassword;

  SetNewPasswordAuthParam({
    this.email,
    this.password,
    this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    }..removeWhere((key, value) => value == null);
  }
}
