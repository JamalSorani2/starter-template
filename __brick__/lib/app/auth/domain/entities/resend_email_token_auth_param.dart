class ResendEmailTokenAuthParam {
  final String? email;

  ResendEmailTokenAuthParam({
    this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    }..removeWhere((key, value) => value == null);
  }
}
