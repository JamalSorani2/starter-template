import 'dart:developer';

import 'package:app_name/common/services/package_info_plus_service.dart';

import '../../app/url.dart';
import '../imports/imports.dart';
import '../presentation/state/bloc/app_manager_bloc.dart';

class CheckVersionService {
  static Future<void> checkForUpdates() async {
    if (kReleaseMode) {
      try {
        final response = await getIt<Dio>().post(
          AppUrl.appVersion,
          options: Options(headers: {}),
        );
        final model = _AppUpdateModel.fromJson(response.data);
        final packageInfo = PackageInfoService();
        await packageInfo.init();

        final String currentVersion = packageInfo.version;
        final String currentBuildNumber = packageInfo.buildNumber;

        final bool updateRequired = _isVersionHigher(
          model.newVersion,
          currentVersion,
        );
        log("update required $updateRequired");
        final bool canUpdateLater =
            int.parse(model.buildNumber) > int.parse(currentBuildNumber) &&
                !updateRequired;
        if (updateRequired || canUpdateLater) {
          getIt<AppManagerBloc>().add(
            AppMangerExpiredApp(
              updateRequired: updateRequired,
              canUpdateLater: canUpdateLater,
              arWhatIsNew: model.arWhatIsNew,
              enWhatIsNew: model.enWhatIsNew,
              newVersion: "${model.newVersion} (${model.buildNumber})",
            ),
          );
        } else {
          getIt<AppManagerBloc>().add(AppMangerUnExpiredApp());
        }
      } catch (e) {
        log("Error while checking version $e");
      }
    }
  }

  static bool _isVersionHigher(String newVersion, String currentVersion) {
    final List<int> newV = newVersion.split('.').map(int.parse).toList();
    final List<int> curV = currentVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < newV.length; i++) {
      if (i >= curV.length || newV[i] > curV[i]) {
        return true;
      }
      if (newV[i] < curV[i]) {
        return false;
      }
    }
    return false;
  }
}

class _AppUpdateModel {
  final String newVersion;
  final String buildNumber;
  final String? enWhatIsNew;
  final String? arWhatIsNew;

  _AppUpdateModel({
    required this.newVersion,
    required this.buildNumber,
    this.enWhatIsNew,
    this.arWhatIsNew,
  });

  // Factory constructor to create an instance from JSON
  factory _AppUpdateModel.fromJson(Map<String, dynamic> json) {
    return _AppUpdateModel(
      newVersion: json['newVersion'] as String,
      buildNumber: json['buildNumber'] as String,
      enWhatIsNew: json['enWhatIsNew'] as String?,
      arWhatIsNew: json['arWhatIsNew'] as String?,
    );
  }
}
