class ChangePasswordAuthParam {
  final String? oldPassword;
  final String? newPassword;
  final String? confirmNewPassword;

  ChangePasswordAuthParam({
    this.oldPassword,
    this.newPassword,
    this.confirmNewPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
    }..removeWhere((key, value) => value == null);
  }
}
