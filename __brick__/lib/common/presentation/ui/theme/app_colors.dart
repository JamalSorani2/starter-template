import '../../../imports/imports.dart';

abstract final class AppColors {
  const AppColors._();

  static void init(bool light) {
    isLight = light;
    getIt<SharedPreferences>().setBool(KIsLight, light);
  }

  static late bool isLight;

  //! Brand Colors =========================================================================
  static const Color _primaryLight = Color(0xFF6366F1);
  static const Color _primaryDark = Color(0xFF4338CA);

  static const Color _secondaryLight = Color(0xFFF59E0B);
  static const Color _secondaryDark = Color(0xFFF59EE);
  static const Color _onSecondatyLight = Color(0xFFFFFFFF);
  static const Color _onSecondatyDark = Color(0xFF000000);

  static Color get primary => isLight ? _primaryLight : _primaryDark;
  static Color get secondary => isLight ? _secondaryLight : _secondaryDark;
  static Color get onSecondary =>
      isLight ? _onSecondatyLight : _onSecondatyDark;

  //! Backgrounds & Surfaces ===============================================================
  static const Color _surface = Color(0xFFFFFFFF);
  static const Color _card = Color(0xFFFFFFFF);

  static const Color _darkSurface = Color(0xFF020617);
  static const Color _darkCard = Color(0xFF020617);

  static Color get surface => isLight ? _surface : _darkSurface;
  static Color get card => isLight ? _card : _darkCard;

  //! Text =================================================================================
  static const Color _textPrimary = Color(0xFF111827);
  static const Color _textSecondary = Color(0xFF6B7280);
  static const Color _textDisabled = Color(0xFF9CA3AF);

  static const Color _darkTextPrimary = Color(0xFFF8FAFC);
  static const Color _darkTextSecondary = Color(0xFFCBD5E1);
  static const Color _darkTextDisabled = Color(0xFF64748B);

  static Color get textPrimary => isLight ? _textPrimary : _darkTextPrimary;
  static Color get textSecondary =>
      isLight ? _textSecondary : _darkTextSecondary;
  static Color get textDisabled => isLight ? _textDisabled : _darkTextDisabled;

  //! Status Colors =======================================================================
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFDC2626);
  static const Color info = Color(0xFF0EA5E9);
  static const Color grey = Color(0xFF6B7280);

  //! Borders & Dividers ==================================================================
  static const Color _border = Color(0xFFE5E7EB);
  static const Color _darkBorder = Color(0xFF1E293B);

  static Color get border => isLight ? _border : _darkBorder;

  //! Overlays ============================================================================
  static const Color _overlayLight = Color(0x66000000);
  static const Color _overlayDark = Color(0x99FFFFFF);

  static Color get overlay => isLight ? _overlayLight : _overlayDark;

  //! Shadow Color =========================================================================
  static const Color _shadow = Color(0xFF000000);
  static const Color _darkShadow = Color(0xFF000000);

  static Color get shadow => isLight ? _shadow : _darkShadow;
}
