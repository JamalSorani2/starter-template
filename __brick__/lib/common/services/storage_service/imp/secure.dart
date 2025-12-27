// ignore_for_file: always_declare_return_types

import 'dart:convert';

import 'package:app_name/app/auth/data/models/login_auth_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../constant/keys.dart';
import '../../../injection/injection.dart';
import '../../../network/models/auth_token_dio.dart';
import '../../../network/models/reactive_token_storage.dart';
import '../storage_service.dart';

class SecureStorageImp<T extends SecureStorage> implements StorageService<T> {
  final FlutterSecureStorage _secureStorage;

  SecureStorageImp(this._secureStorage);

  @override
  getBool(String key) async {
    final value = await _secureStorage.read(key: key);
    return value == null ? null : value.toLowerCase() == 'true';
  }

  @override
  getInt(String key) async {
    final value = await _secureStorage.read(key: key);
    return value == null ? null : int.tryParse(value);
  }

  @override
  Future<String?>? getString(String key) async {
    return await _secureStorage.read(key: key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  @override
  Future<void> setInt(String key, int value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  @override
  Future<void> setString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  @override
  getStringList(String key) async {
    final value = await _secureStorage.read(key: key);
    return value?.split(',');
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    await _secureStorage.write(key: key, value: value.join(','));
  }

  @override
  Future<void> remove(String key) async {
    await _secureStorage.delete(key: key);
  }

  @override
  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }

  @override
  Future<LoginAuthModel?> getUser() async {
    final String? string = await getString(KUser);
    if (string != null) {
      final Map<String, dynamic> d = json.decode(string);
      final user = LoginAuthModel.fromJson(d);
      return user;
    }
    return null;
  }

  @override
  Future<bool> isAuthenticated() async {
    final String? string = await getString(KUser);
    return string != null && string.isNotEmpty;
  }

  @override
  Future<void> removeUser() async {
    await remove(KUser);
  }

  @override
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
