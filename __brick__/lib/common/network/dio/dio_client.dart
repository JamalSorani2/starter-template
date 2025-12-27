import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import '../../../app/auth/domain/repository/auth_repository.dart';
import '../../../app/url.dart';
import '../../imports/imports.dart';
import '../exception/error_interceptor.dart';
import 'custom_dio_interceptor.dart';
import 'localization_interceptor.dart';
import 'refresh_token_helper.dart';

class DioClient with DioMixin implements Dio {
  DioClient(this.baseUrl, {List<Interceptor> interceptors = const []}) {
    options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 30),
    );
    httpClientAdapter = HttpClientAdapter();
    options
      ..baseUrl = baseUrl
      ..headers = {
        'accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
      };
    if (interceptors.isNotEmpty) {
      this.interceptors.addAll(interceptors);
    }
    final customDioLogger = CustomDioInterceptor();
    final tokenDio = Dio(options)..interceptors.addAll([customDioLogger]);
    this.interceptors.addAll([
      RefreshTokenInterceptor<AuthTokenModel>(
        debugLog: true,
        tokenProtocol: TokenProtocol(
          shouldRefresh: (response, token) {
            return response?.statusCode == 401;
          },
        ),
        onRevoked: (dioError) {
          getIt<AuthRepository>().logout();
          if (dioError.response?.statusCode == 403) {}
          return null;
        },
        tokenStorage: getIt<ReactiveTokenStorage>(),
        tokenDio: tokenDio,
        refreshToken: (token, tokenDio) async {
          final response = await tokenDio.post(
            AppUrl.refreshTokenAuth,
            data: {'isDevice': true, 'refreshToken': token.refreshToken},
          );
          final authTokenModel = AuthTokenModel.fromMap(response.data);

          await updateStorageToken(
            authTokenModel.accessToken,
            authTokenModel.refreshToken ?? token.refreshToken,
          );
          return authTokenModel;
        },
      ),
      LocalizationInterceptor(),
      if (kDebugMode) customDioLogger,
      ErrorInterceptor(),
    ]);
  }

  final String baseUrl;
}
