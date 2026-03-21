import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/url.dart';
import '../../network/dio/dio_client.dart';
import '../../network/models/reactive_token_storage.dart';
import '../../services/storage_service/storage_service.dart';
import '../injection.dart';

Future<void> generalInjection() async {
  // Register SharedPreferences for lightweight local storage
  getIt.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  // Register FlutterSecureStorage for storing sensitive data securely
  getIt.registerSingleton<FlutterSecureStorage>(
    const FlutterSecureStorage(
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    ),
  );

  // Register a secure storage service wrapper for FlutterSecureStorage
  getIt.registerSingleton<SecureStorage>(
    SecureStorage(
      getIt<FlutterSecureStorage>(),
    ),
  );

  // Register a ReactiveTokenStorage for managing authentication tokens
  getIt.registerSingleton<ReactiveTokenStorage>(
    ReactiveTokenStorage(
      getIt<SecureStorage>(),
    ), // Inject secure storage service
  );

  // Register a configured Dio HTTP client with a base URL
  getIt.registerSingleton<Dio>(
    DioClient(
      "${AppUrl.baseUrlDevelopment}api/",
    ), // Set the base URL for API calls
  );
}
