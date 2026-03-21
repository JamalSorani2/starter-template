import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class DeviceInfoService {
  static final DeviceInfoPlugin _plugin = DeviceInfoPlugin();

  Future<AppDeviceInfo> getInfo() async {
    final locale = WidgetsBinding.instance.platformDispatcher.locale.toString();
    final timeZone = DateTime.now().timeZoneName;

    if (kIsWeb) {
      final info = await _plugin.webBrowserInfo;

      return AppDeviceInfo(
        platform: 'web',
        deviceId: info.userAgent ?? 'web',
        brand: 'browser',
        model: info.browserName.name,
        manufacturer: 'browser',
        osName: info.platform ?? 'web',
        osVersion: info.appVersion ?? '',
        sdkInt: null,
        isPhysicalDevice: true,
        locale: locale,
        timeZone: timeZone,
      );
    }

    if (Platform.isAndroid) {
      final info = await _plugin.androidInfo;

      return AppDeviceInfo(
        platform: 'android',
        deviceId: info.id,
        brand: info.brand,
        model: info.model,
        manufacturer: info.manufacturer,
        osName: 'Android',
        osVersion: info.version.release,
        sdkInt: info.version.sdkInt,
        isPhysicalDevice: info.isPhysicalDevice,
        locale: locale,
        timeZone: timeZone,
      );
    }

    if (Platform.isIOS) {
      final info = await _plugin.iosInfo;

      return AppDeviceInfo(
        platform: 'ios',
        deviceId: info.identifierForVendor ?? 'unknown',
        brand: 'Apple',
        model: info.utsname.machine,
        manufacturer: 'Apple',
        osName: 'iOS',
        osVersion: info.systemVersion,
        sdkInt: null,
        isPhysicalDevice: info.isPhysicalDevice,
        locale: locale,
        timeZone: timeZone,
      );
    }

    if (Platform.isMacOS) {
      final info = await _plugin.macOsInfo;

      return AppDeviceInfo(
        platform: 'macos',
        deviceId: info.systemGUID ?? 'unknown',
        brand: 'Apple',
        model: info.model,
        manufacturer: 'Apple',
        osName: 'macOS',
        osVersion: info.osRelease,
        sdkInt: null,
        isPhysicalDevice: true,
        locale: locale,
        timeZone: timeZone,
      );
    }

    if (Platform.isWindows) {
      final info = await _plugin.windowsInfo;

      return AppDeviceInfo(
        platform: 'windows',
        deviceId: info.deviceId,
        brand: 'Microsoft',
        model: info.computerName,
        manufacturer: 'Microsoft',
        osName: 'Windows',
        osVersion: info.displayVersion,
        sdkInt: null,
        isPhysicalDevice: true,
        locale: locale,
        timeZone: timeZone,
      );
    }

    if (Platform.isLinux) {
      final info = await _plugin.linuxInfo;

      return AppDeviceInfo(
        platform: 'linux',
        deviceId: info.machineId ?? 'unknown',
        brand: info.name,
        model: info.prettyName,
        manufacturer: info.id,
        osName: 'Linux',
        osVersion: info.version ?? '',
        sdkInt: null,
        isPhysicalDevice: true,
        locale: locale,
        timeZone: timeZone,
      );
    }

    throw UnsupportedError('Unsupported platform');
  }
}

class AppDeviceInfo {
  const AppDeviceInfo({
    required this.platform,
    required this.deviceId,
    required this.brand,
    required this.model,
    required this.manufacturer,
    required this.osName,
    required this.osVersion,
    required this.sdkInt,
    required this.isPhysicalDevice,
    required this.locale,
    required this.timeZone,
  });

  final String platform; // android / ios / web / macos / windows
  final String deviceId; // best-effort unique id
  final String brand;
  final String model;
  final String manufacturer;
  final String osName;
  final String osVersion;
  final int? sdkInt; // Android only
  final bool isPhysicalDevice;
  final String locale;
  final String timeZone;

  Map<String, dynamic> toJson() => {
        'platform': platform,
        'deviceId': deviceId,
        'brand': brand,
        'model': model,
        'manufacturer': manufacturer,
        'osName': osName,
        'osVersion': osVersion,
        'sdkInt': sdkInt,
        'isPhysicalDevice': isPhysicalDevice,
        'locale': locale,
        'timeZone': timeZone,
      };
}
