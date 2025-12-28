import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService {
  PackageInfo? _packageInfo;

  /// Initialize and load package info
  Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  /// Get app name
  String get appName => _packageInfo?.appName ?? '';

  /// Get package name / bundle ID
  String get packageName => _packageInfo?.packageName ?? '';

  /// Get app version (e.g., 1.0.0)
  String get version => _packageInfo?.version ?? '';

  /// Get build number (e.g., 1)
  String get buildNumber => _packageInfo?.buildNumber ?? '';

  /// Get display version (version+build)
  String get displayVersion => '${version}+${buildNumber}';
}
