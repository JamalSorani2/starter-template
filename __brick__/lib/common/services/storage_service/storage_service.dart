// ignore_for_file: always_declare_return_types

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/auth/data/models/login_auth_model.dart';
import 'imp/secure.dart';
import 'imp/shared.dart';

abstract class SharedStorage {}

abstract class SecureStorage {}

abstract class HiveStorage {}

abstract class StorageService<T> {
  bool? getBool(String key);

  getString(String key);

  int? getInt(String key);

  Future<List<String>?> getStringList(String key);

  Future setStringList(String key, List<String> value);

  Future setBool(String key, bool value);

  Future setString(String key, String value);

  Future setInt(String key, int value);

  remove(String key);

  Future<LoginAuthModel?> getUser();

  Future<bool> isAuthenticated();

  Future<void> removeUser();

  Future<void> saveUser(LoginAuthModel value);

  Future<void> clear();

  factory StorageService.shared(SharedPreferences sharedPreferences) =>
      StorageServiceSharedImp(sharedPreferences);
  factory StorageService.secure(FlutterSecureStorage flutterSecureStorage) =>
      SecureStorageImp(flutterSecureStorage);
}
