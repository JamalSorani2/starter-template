class SignUpAuthParam {
  final String? clickId; //!Format: uuid
  final String? email;
  final String? password;
  final String? lastName;
  final String? firstName;
  final String? phoneNumber;

  SignUpAuthParam({
    this.clickId,
    this.email,
    this.password,
    this.lastName,
    this.firstName,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'clickId': clickId,
      'email': email,
      'password': password,
      'lastName': lastName,
      'firstName': firstName,
      'phoneNumber': phoneNumber,
    }..removeWhere((key, value) => value == null);
  }
}
