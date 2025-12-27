import 'package:dio/dio.dart';
import '../../constant/keys.dart';
import '../../injection/injection.dart';
import '../../services/storage_service/storage_service.dart';

class LocalizationInterceptor extends Interceptor {
  LocalizationInterceptor();

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addAll({
      'Accept-Language':
          (await getIt<StorageService>().getString(KUserLanguage)) ?? 'ar',
      //  "X-TimeZoneId": await FlutterTimezone.getLocalTimezone()
    });
    handler.next(options);
  }
}
