import '/common/services/check_version_service.dart';
import '../../services/device_info_service.dart';
import '../../services/notification_service.dart';
import '../../services/package_info_plus_service.dart';
import '../../services/url_launcher_service.dart';
import '../injection.dart';

/// Registers all service dependencies.
Future<void> servicesInjection() async {
  final checkVersionService = CheckVersionService();
  await checkVersionService.checkForUpdates();
  getIt.registerSingleton<CheckVersionService>(checkVersionService);

  final deviceInfoService = DeviceInfoService();
  final appDeviceInfo = await deviceInfoService.getInfo();
  getIt.registerSingleton<AppDeviceInfo>(appDeviceInfo);

  final packageInfoService = PackageInfoService();
  await packageInfoService.init();
  getIt.registerSingleton<PackageInfoService>(packageInfoService);

  final notificationService = NotificationService();
  await notificationService.initialize();
  getIt.registerSingleton<NotificationService>(notificationService);
  getIt.registerSingleton<PackageInfoService>(packageInfoService);

  final urlLauncherService = UrlLauncherService();
  getIt.registerSingleton<UrlLauncherService>(urlLauncherService);
}
