class RequestConfirmPhoneNumberAuthParam {
  final String? phoneNumber;

  RequestConfirmPhoneNumberAuthParam({
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
    }..removeWhere((key, value) => value == null);
  }
}
