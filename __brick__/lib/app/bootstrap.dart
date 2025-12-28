import 'package:app_name/common/services/notification_service.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../common/imports/imports.dart';
import '../common/presentaion/state/observer/app_bloc_observer.dart';

Future<void> bootstrap(Widget mainApp) async {
  try {
    await initInjection();
    await getIt<ReactiveTokenStorage>().loadToken();
  } finally {
    if (kDebugMode) {
      Bloc.observer = AppBlocObserver();
      if (kDebugMode) {
        ErrorWidget.builder = (FlutterErrorDetails details) {
          return ErrorWidget(details.exception);
        };
      }
    }
    runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => mainApp,
      ),
    );
    await _initUnUregentServices();
  }
}

Future<void> _initUnUregentServices() async {
  await NotificationService.initialize();
  if (kReleaseMode) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
}
