import 'dart:async';
import 'dart:convert';

import 'package:dio_refresh_bot/dio_refresh_bot.dart';

import '../../../../../../common/constant/keys.dart';
import '../../services/storage_service/storage_service.dart';
import 'auth_token_dio.dart';

class ReactiveTokenStorage extends BotMemoryTokenStorage<AuthTokenModel>
    with RefreshBotMixin<AuthTokenModel> {
  final SecureStorage storageService;

  ReactiveTokenStorage(this.storageService) : super();

  @override
  FutureOr<void> delete([String? message]) async {
    await storageService.remove(KUserToken);
    _cachedToken = null;
    super.delete(message);
  }

  @override
  FutureOr<void> write(AuthTokenModel? token) async {
    if (token != null) {
      await storageService.setString(KUserToken, json.encode(token.toMap()));
    } else {
      await storageService.remove(KUserToken);
    }
    _cachedToken = token;
    super.write(token);
  }

  AuthTokenModel? _cachedToken;

  @override
  AuthTokenModel? read() {
    return _cachedToken;
  }

  Future<void> loadToken() async {
    final String? string = await storageService.getString(KUserToken);
    if (string != null) {
      _cachedToken = AuthTokenModel.fromMap(json.decode(string));
    } else {
      _cachedToken = null;
    }
  }
}
