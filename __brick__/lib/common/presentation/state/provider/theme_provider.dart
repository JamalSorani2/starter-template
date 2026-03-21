import '../../../imports/imports.dart';

class ThemeProvider extends ChangeNotifier {
  bool? _isLightMode;

  ThemeProvider() {
    _isLightMode = getIt<SharedPreferences>().getBool(KIsLight);
    AppColors.init(_isLightMode ?? ThemeMode.system == ThemeMode.light);
  }

  // Computed theme mode
  ThemeMode get themeMode {
    if (_isLightMode == true) {
      return ThemeMode.light;
    }
    if (_isLightMode == false) {
      return ThemeMode.dark;
    }
    return ThemeMode.system;
  }

  // Toggle theme mode
  void toggleTheme() {
    if (_isLightMode == true) {
      _isLightMode = false;
    } else {
      _isLightMode = true;
    }
    getIt<SharedPreferences>().setBool(KIsLight, _isLightMode!);
    AppColors.init(_isLightMode!);
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        _isLightMode = true;
        break;
      case ThemeMode.dark:
        _isLightMode = false;
        break;
      case ThemeMode.system:
        _isLightMode = null;
        break;
    }
    getIt<SharedPreferences>().setBool(KIsLight, _isLightMode!);
    AppColors.init(_isLightMode ?? ThemeMode.system == ThemeMode.light);
    notifyListeners();
  }
}
