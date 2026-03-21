import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../app/auth/data/models/login_auth_model.dart';
import '../imports/imports.dart';

class SecureStorage {
  final FlutterSecureStorage _secureStorage;

  SecureStorage(this._secureStorage);

  Future<bool?>? getBool(String key) async {
    final value = await _secureStorage.read(key: key);
    return value == null ? null : value.toLowerCase() == 'true';
  }

  Future<int?>? getInt(String key) async {
    final value = await _secureStorage.read(key: key);
    return value == null ? null : int.tryParse(value);
  }

  Future<String?>? getString(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> setBool(String key, bool value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  Future<void> setInt(String key, int value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  Future<void> setString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<List<String>?>? getStringList(String key) async {
    final value = await _secureStorage.read(key: key);
    return value?.split(',');
  }

  Future<void> setStringList(String key, List<String> value) async {
    await _secureStorage.write(key: key, value: value.join(','));
  }

  Future<void> remove(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }

  Future<LoginAuthModel?> getUser() async {
    final String? string = await getString(KUser);
    if (string != null) {
      final Map<String, dynamic> d = json.decode(string);
      final user = LoginAuthModel.fromJson(d);
      return user;
    }
    return null;
  }

  Future<bool> isAuthenticated() async {
    final String? string = await getString(KUser);
    return string != null && string.isNotEmpty;
  }

  Future<void> removeUser() async {
    await remove(KUser);
  }

  Future<void> saveUser(LoginAuthModel value) async {
    await setString(KUser, jsonEncode(value.toJson()));
    await getIt<ReactiveTokenStorage>().write(
      AuthTokenModel(
        accessToken: value.token,
        refreshToken: value.refreshToken,
      ),
    );
    await getIt<ReactiveTokenStorage>().loadToken();
  }
}
