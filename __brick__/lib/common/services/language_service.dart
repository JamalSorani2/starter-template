import '../imports/imports.dart';

class LanguageService {
  LanguageService._();

  static Future<void> changeLanguage(
    BuildContext context,
    String languageCode,
  ) async {
    final locale = Locale(languageCode);
    await context.setLocale(locale);

    await getIt<SharedPreferences>().setString(KUserLanguage, languageCode);
  }
}
