import 'package:easy_localization/easy_localization.dart';
import 'common/translate/app_local.dart';
import 'app/bootstrap.dart';
import 'app/my_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await bootstrap(
    EasyLocalization(
      supportedLocales: AppLocale.supportedLocales,
      path: AppLocale.path,
      fallbackLocale: AppLocale.fallbackLocale,
      child: const MyApp(),
    ),
  );
}
