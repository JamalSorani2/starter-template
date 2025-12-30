class ResendPhoneNumberCodeAuthParam {
  final String? phoneNumber;

  ResendPhoneNumberCodeAuthParam({
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
    }..removeWhere((key, value) => value == null);
  }
}
