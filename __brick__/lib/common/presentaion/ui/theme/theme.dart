import 'package:google_fonts/google_fonts.dart';

import '../../../imports/imports.dart';

abstract final class AppTheme {
  const AppTheme._();

  static TextTheme textTheme(bool isEnglish) {
    final color = AppColors.textPrimary;
    final font =
        isEnglish ? GoogleFonts.interTextTheme : GoogleFonts.cairoTextTheme;

    return font(
      TextTheme(
        displayLarge: TextStyle(
          fontSize: 57.sp,
          height: 64 / 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          color: color,
        ),
        displayMedium: TextStyle(
          fontSize: 45.sp,
          height: 52 / 45,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: color,
        ),
        displaySmall: TextStyle(
          fontSize: 36.sp,
          height: 44 / 36,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: color,
        ),
        headlineLarge: TextStyle(
          fontSize: 32.sp,
          height: 40 / 32,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: color,
        ),
        headlineMedium: TextStyle(
          fontSize: 28.sp,
          height: 36 / 28,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: color,
        ),
        headlineSmall: TextStyle(
          fontSize: 24.sp,
          height: 32 / 24,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: color,
        ),
        titleLarge: TextStyle(
          fontSize: 22.sp,
          height: 28 / 22,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: color,
        ),
        titleMedium: TextStyle(
          fontSize: 16.sp,
          height: 24 / 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: color,
        ),
        titleSmall: TextStyle(
          fontSize: 14.sp,
          height: 20 / 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: color,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.sp,
          height: 24 / 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: color,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          height: 20 / 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: color,
        ),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          height: 16 / 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: color,
        ),
        labelLarge: TextStyle(
          fontSize: 14.sp,
          height: 20 / 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: color,
        ),
        labelMedium: TextStyle(
          fontSize: 12.sp,
          height: 16 / 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: color,
        ),
        labelSmall: TextStyle(
          fontSize: 11.sp,
          height: 16 / 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: color,
        ),
      ),
    );
  }

  static ThemeData theme(bool isEnglish, bool isLight) {
    final colorScheme = isLight ? ColorScheme.light : ColorScheme.dark;
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColors.primary,
      brightness: isLight ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: AppColors.surface,
      primaryColor: AppColors.primary,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primary,
      ),
      colorScheme: colorScheme(
        primary: AppColors.primary,
        primaryContainer: AppColors.primary,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondary,
        onSecondaryContainer: AppColors.onSecondary,
        onSurface: AppColors.textPrimary,
        surfaceContainerHighest: AppColors.card,
        onSurfaceVariant: AppColors.textSecondary,
        error: AppColors.danger,
        outline: AppColors.border,
        outlineVariant: AppColors.border,
        shadow: AppColors.shadow,
        scrim: AppColors.overlay,
        inverseSurface: AppColors.textPrimary,
        onInverseSurface: AppColors.surface,
        inversePrimary: AppColors.primary,
      ),
      textTheme: textTheme(isEnglish),
      switchTheme: const SwitchThemeData(padding: EdgeInsets.zero),
      elevatedButtonTheme: AppStyles.elevatedButtonStyle,
      outlinedButtonTheme: AppStyles.outlineButtonStyle,
      textButtonTheme: AppStyles.textButtonStyle,
      iconButtonTheme: AppStyles.iconButtonStyle,
      chipTheme: AppStyles.chipTheme,
      inputDecorationTheme: AppStyles.inputDecorationThemeLight,
      dialogTheme: AppStyles.dialogTheme,
      cardTheme: AppStyles.cardTheme,
      iconTheme: AppStyles.iconTheme,
      checkboxTheme: AppStyles.checkBoxTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
    );
  }
}
