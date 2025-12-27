import 'package:app_name/app/auth/data/models/login_auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage_service.dart';

class StorageServiceSharedImp<T extends SharedStorage>
    implements StorageService<T> {
  final SharedPreferences? _sharedPreferences;

  StorageServiceSharedImp(SharedPreferences sharedPreferences)
      : _sharedPreferences = sharedPreferences;

  @override
  bool? getBool(String key) {
    return _sharedPreferences!.getBool(key);
  }

  @override
  int? getInt(String key) {
    return _sharedPreferences!.getInt(key);
  }

  @override
  String? getString(String key) {
    return _sharedPreferences!.getString(key);
  }

  @override
  Future setBool(String key, bool value) async {
    await _sharedPreferences!.setBool(key, value);
  }

  @override
  Future setInt(String key, int value) async {
    await _sharedPreferences!.setInt(key, value);
  }

  @override
  Future setString(String key, String value) async {
    await _sharedPreferences!.setString(key, value);
    await _sharedPreferences!.reload();
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    await _sharedPreferences!.reload();
    return _sharedPreferences!.getStringList(key);
  }

  @override
  Future<void> remove(String key) async {
    await _sharedPreferences!.remove(key);
  }

  @override
  Future setStringList(String key, List<String> value) async {
    await _sharedPreferences!.setStringList(key, value);
    await _sharedPreferences!.reload();
  }

  @override
  Future<void> clear() async {
    await _sharedPreferences!.clear();
  }

  @override
  Future<LoginAuthModel?> getUser() {
    throw UnimplementedError();
  }

  @override
  Future<bool> isAuthenticated() {
    throw UnimplementedError();
  }

  @override
  Future<void> removeUser() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveUser(LoginAuthModel value) {
    throw UnimplementedError();
  }
}
