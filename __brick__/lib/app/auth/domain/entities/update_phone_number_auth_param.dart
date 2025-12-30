class UpdatePhoneNumberAuthParam {
  final String? phoneNumber;

  UpdatePhoneNumberAuthParam({
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
    }..removeWhere((key, value) => value == null);
  }
}
