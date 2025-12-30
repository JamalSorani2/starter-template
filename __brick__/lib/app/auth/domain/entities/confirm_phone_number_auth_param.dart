class ConfirmPhoneNumberAuthParam {
  final String? phoneNumber;
  final String? code;

  ConfirmPhoneNumberAuthParam({
    this.phoneNumber,
    this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'code': code,
    }..removeWhere((key, value) => value == null);
  }
}
