import 'package:app_name/app/auth/presentation/state/bloc/auth_bloc.dart';

import '/app/auth/domain/entities/logout_auth_param.dart';
import '../../../app/url.dart';
import '../../imports/imports.dart';
import '../exception/error_interceptor.dart';
import 'custom_dio_interceptor.dart';
import 'localization_interceptor.dart';
import 'refresh_token_helper.dart';

class DioClient extends DioMixin {
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
    final baseInterceptors = List<Interceptor>.from(interceptors);
    if (baseInterceptors.isNotEmpty) {
      this.interceptors.addAll(baseInterceptors);
    }

    // Use a dedicated logger instance for each Dio client.
    final appDioLogger = CustomDioInterceptor();
    final tokenDioLogger = CustomDioInterceptor();

    final tokenDio = Dio(options);
    if (baseInterceptors.isNotEmpty) {
      // Ensure refresh-token requests/responses go through the same
      // caller-provided interceptors (recording, analytics, etc.).
      tokenDio.interceptors.addAll(baseInterceptors);
    }
    tokenDio.interceptors.add(tokenDioLogger);

    this.interceptors.addAll([
      RefreshTokenInterceptor<AuthTokenModel>(
        debugLog: true,
        tokenProtocol: TokenProtocol(
          shouldRefresh: (response, token) {
            // if (token != null) {
            //   isAboutToExpire = isTokenAboutToExpire(token.accessToken);
            // }

            return token == null ||
                token.accessToken.isEmpty ||
                response?.statusCode == 401;
          },
        ),
        onRevoked: (dioError) {
          if (dioError.response?.statusCode == 403) {
            return null;
          }
          return null;
        },
        tokenStorage: getIt<ReactiveTokenStorage>(),
        tokenDio: tokenDio,
        refreshToken: (token, tokenDio) async {
          try {
            final response = await tokenDio.post(
              AppUrl.refreshToken,
              data: {
                'refreshToken': token.refreshToken,
              },
              options: Options(
                headers: {'Authorization': 'Bearer ${token.accessToken}'},
              ),
            );
            final authTokenModel =
                AuthTokenModel.fromMap(response.data['data']);
            if (authTokenModel.accessToken.isEmpty &&
                authTokenModel.refreshToken != null &&
                authTokenModel.refreshToken!.isNotEmpty) {
              await updateStorageToken(
                authTokenModel.accessToken,
                authTokenModel.refreshToken ?? token.refreshToken,
              );
            }
            return authTokenModel;
          } catch (e) {
            if (!e.toString().contains("502")) {
              try {
                getIt<AuthBloc>()
                    .add(LogoutAuthEvent(logoutAuthParam: LogoutAuthParam()));
              } catch (_) {}
            }
          }
          return const AuthTokenModel(accessToken: "", refreshToken: "");
        },
      ),
      LocalizationInterceptor(),
      if (kDebugMode) appDioLogger,
      ErrorInterceptor(),
    ]);
  }

  final String baseUrl;
}
