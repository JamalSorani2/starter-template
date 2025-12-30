class RefreshTokenAuthParam {
  final String? refreshToken;
  final bool isDevice;

  RefreshTokenAuthParam({
    this.refreshToken,
    required this.isDevice,
  });

  Map<String, dynamic> toJson() {
    return {
      'refreshToken': refreshToken,
      'isDevice': isDevice,
    }..removeWhere((key, value) => value == null);
  }
}
