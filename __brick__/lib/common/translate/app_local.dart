import 'dart:ui';

class AppLocale {
  static const String path = 'assets/l10n';
  static List<Locale> supportedLocales = const [Locale('ar'), Locale('en')];
  static Locale fallbackLocale = const Locale('ar');
}
