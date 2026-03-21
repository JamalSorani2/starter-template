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
        /// ========== DISPLAY ==========
        displayLarge: TextStyle(
          // Display 1
          fontSize: 64.sp,
          height: 1.1,
          fontWeight: FontWeight.w400,
          color: color,
        ),
        displayMedium: TextStyle(
          // Display 2
          fontSize: 56.sp,
          height: 1.1,
          fontWeight: FontWeight.w400,
          color: color,
        ),
        displaySmall: TextStyle(
          // Display 3
          fontSize: 48.sp,
          height: 1.15,
          fontWeight: FontWeight.w400,
          color: color,
        ),
        headlineLarge: TextStyle(
          // Display 4
          fontSize: 40.sp,
          height: 1.2,
          fontWeight: FontWeight.w400,
          color: color,
        ),

        /// ========== HEADINGS ==========
        headlineMedium: TextStyle(
          // H1
          fontSize: 32.sp,
          height: 1.25,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        headlineSmall: TextStyle(
          // H2
          fontSize: 28.sp,
          height: 1.3,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        titleLarge: TextStyle(
          // H3
          fontSize: 24.sp,
          height: 1.3,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        titleMedium: TextStyle(
          // H4
          fontSize: 20.sp,
          height: 1.35,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        titleSmall: TextStyle(
          // H5
          fontSize: 18.sp,
          height: 1.35,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        labelLarge: TextStyle(
          // H6
          fontSize: 16.sp,
          height: 1.4,
          fontWeight: FontWeight.w600,
          color: color,
        ),

        /// ========== PARAGRAPHS ==========
        bodyLarge: TextStyle(
          // Paragraph Lead
          fontSize: 18.sp,
          height: 1.6,
          fontWeight: FontWeight.w400,
          color: color,
        ),
        bodyMedium: TextStyle(
          // Paragraph
          fontSize: 16.sp,
          height: 1.6,
          fontWeight: FontWeight.w400,
          color: color,
        ),
        bodySmall: TextStyle(
          // Paragraph Small
          fontSize: 14.sp,
          height: 1.6,
          fontWeight: FontWeight.w400,
          color: color,
        ),

        /// ========== LABELS / CAPTION ==========
        labelMedium: TextStyle(
          // Small UI text
          fontSize: 12.sp,
          height: 1.4,
          fontWeight: FontWeight.w500,
          color: color,
        ),
        labelSmall: TextStyle(
          // Caption
          fontSize: 11.sp,
          height: 1.3,
          fontWeight: FontWeight.w400,
          color: color,
        ),
      ),
    );
  }

  static ThemeData theme(bool isEnglish, bool isLight) {
    final colorScheme = isLight ? ColorScheme.light : ColorScheme.dark;
    return ThemeData(
      useMaterial3: true,
      brightness: isLight ? Brightness.light : Brightness.dark,
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
      switchTheme: const SwitchThemeData(
        padding: EdgeInsets.zero,
      ),
      elevatedButtonTheme: AppStyles.elevatedButtonStyle,
      outlinedButtonTheme: AppStyles.outlineButtonStyle,
      textButtonTheme: AppStyles.textButtonStyle,
      iconButtonTheme: AppStyles.iconButtonStyle,
      chipTheme: AppStyles.chipTheme,
      inputDecorationTheme: AppStyles.inputDecorationTheme(isEnglish, isLight),
      dialogTheme: AppStyles.dialogTheme,
      cardTheme: AppStyles.cardTheme,
      iconTheme: IconThemeData(
        size: AppDesign.icon,
        color: AppColors.textPrimary,
      ),
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
        iconTheme: IconThemeData(color: AppColors.primary),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: AppColors.surface,
        elevation: 1,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(16.r),
          ),
        ),
      ),
    );
  }
}
