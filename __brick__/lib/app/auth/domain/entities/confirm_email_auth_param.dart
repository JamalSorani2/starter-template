class ConfirmEmailAuthParam {
  final String? email;
  final String? code;

  ConfirmEmailAuthParam({
    this.email,
    this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'code': code,
    }..removeWhere((key, value) => value == null);
  }
}
