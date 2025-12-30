import '/common/imports/imports.dart';

class LocalizationInterceptor extends Interceptor {
  LocalizationInterceptor();

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addAll({
      'Accept-Language':
          (await getIt<SharedPreferences>().getString(KUserLanguage)) ?? 'ar',
      //  "X-TimeZoneId": await FlutterTimezone.getLocalTimezone()
    });
    handler.next(options);
  }
}
