import '../imports/imports.dart';

class LanguageService {
  LanguageService._();

  static late BuildContext _context; // store context from init

  /// Initialize service with context and load saved language
  static Future<void> init(BuildContext context) async {
    _context = context;
    final languageCode = getIt<SharedPreferences>().getString(KUserLanguage);
    if (languageCode != null) {
      await _context.setLocale(Locale(languageCode));
    }
  }

  /// Change language anywhere without passing context
  static Future<void> changeLanguage(String languageCode) async {
    final locale = Locale(languageCode);
    await _context.setLocale(locale);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(KUserLanguage, languageCode);
  }
}
