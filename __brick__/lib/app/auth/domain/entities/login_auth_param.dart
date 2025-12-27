class LoginAuthParam {
  final String? login;
  final bool isEmail;
  final String? password;
  final String? googleAuthenticatorCode;
  final String? whatsAppCode;

  LoginAuthParam({
    this.login,
    required this.isEmail,
    this.password,
    this.googleAuthenticatorCode,
    this.whatsAppCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'isEmail': isEmail,
      'password': password,
      'googleAuthenticatorCode': googleAuthenticatorCode,
      'whatsAppCode': whatsAppCode,
    }..removeWhere((key, value) => value == null);
  }
}

class ClientSessionDtoParam {
  final String? ip;
  final num lat; //!Format: double
  final num long; //!Format: double
  final int network; //!Format: int32
  final String? osVersion;
  final String? brand;
  final String? timeZone;
  final String? browserInfo;
  final String? fcmToken;
  final String? deviceId;
  final String? device;

  ClientSessionDtoParam({
    this.ip,
    required this.lat,
    required this.long,
    required this.network,
    this.osVersion,
    this.brand,
    this.timeZone,
    this.browserInfo,
    this.fcmToken,
    this.deviceId,
    this.device,
  });

  Map<String, dynamic> toJson() {
    return {
      'ip': ip,
      'lat': lat,
      'long': long,
      'network': network,
      'osVersion': osVersion,
      'brand': brand,
      'timeZone': timeZone,
      'browserInfo': browserInfo,
      'fcmToken': fcmToken,
      'deviceId': deviceId,
      'device': device,
    }..removeWhere((key, value) => value == null);
  }
}
