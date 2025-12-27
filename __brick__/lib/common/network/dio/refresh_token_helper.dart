import 'package:app_name/common/imports/imports.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../app/auth/data/models/login_auth_model.dart';

bool isTokenAboutToExpire(String token, {int bufferTimeInMinutes = 5}) {
  try {
    final expirationDate = JwtDecoder.getExpirationDate(token);
    final now = DateTime.now();

    final bufferTime = expirationDate.subtract(
      Duration(minutes: bufferTimeInMinutes),
    );
    final remaining = expirationDate.difference(now);

    if (remaining.isNegative) {
      printR('⏳ Token already expired');
    } else {
      final days = remaining.inDays;
      final hours = remaining.inHours % 24;
      final minutes = remaining.inMinutes % 60;
      printM(
        '✅ Token still valid for: $days d, $hours h, $minutes m'
        ' (${remaining.inMinutes} minutes total)',
      );
    }

    return now.isAfter(bufferTime);
  } catch (e) {
    printR('Error decoding token: $e');
    return true; // Treat invalid token as expired
  }
}

Future<void> updateStorageToken(String token, String? refreshToken) async {
  final storage = getIt<StorageService<SecureStorage>>();
  final LoginAuthModel? user = await storage.getUser();
  if (user != null) {
    await storage.saveUser(
      user.copyWith(token: token, refreshToken: refreshToken),
    );
  }
}
