import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';

import '../../../imports/imports.dart';

abstract final class AppStyles {
  const AppStyles._();

  //! Button Style ================================================================================
  static final ElevatedButtonThemeData elevatedButtonStyle =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(AppDesign.buttonHeight),
      shape: RoundedRectangleBorder(
        borderRadius: AppDesign.radius,
      ),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );

  static final OutlinedButtonThemeData outlineButtonStyle =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: Size.fromHeight(AppDesign.buttonHeight),
      shape: RoundedRectangleBorder(
        borderRadius: AppDesign.radius,
      ),
      side: BorderSide(color: AppColors.primary),
    ),
  );

  static final TextButtonThemeData textButtonStyle = TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: AppDesign.radius,
      ),
      foregroundColor: AppColors.primary,
    ),
  );

  static final IconButtonThemeData iconButtonStyle = IconButtonThemeData(
    style: IconButton.styleFrom(
      padding: EdgeInsets.zero,
      maximumSize: Size(AppDesign.icon, AppDesign.icon),
      minimumSize: Size(AppDesign.icon, AppDesign.icon),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      foregroundColor: AppColors.primary,
      iconSize: AppDesign.icon,
    ),
  );

  //! Chips ================================================================================
  static final ChipThemeData chipTheme = ChipThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: AppDesign.radius,
    ),
    backgroundColor: AppColors.surface,
    selectedColor: AppColors.primary,
    disabledColor: AppColors.border,
    labelStyle: TextStyle(color: AppColors.textSecondary),
  );

  //! Inputs ===============================================================================
  static InputDecorationTheme inputDecorationTheme(
    bool isEnglish,
    bool isLight,
  ) {
    final textTheme = AppTheme.textTheme(isEnglish);
    final borderWith = 1.0;

    final border = GradientOutlineInputBorder(
      borderRadius: AppDesign.radius,
      width: borderWith,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          "#D9D9D9".toColor().withValues(alpha: isLight ? 0.6 : 0.2),
          Colors.white.withValues(alpha: isLight ? 1 : 0.8),
          Colors.white.withValues(alpha: isLight ? 1 : 0.8),
          "#D9D9D9".toColor().withValues(alpha: isLight ? 0.6 : 0.2),
        ],
      ),
    );
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.card.withValues(alpha: isLight ? 0.2 : 0.04),
      contentPadding: AppDesign.inputContentPadding,
      border: border,
      enabledBorder: border,
      focusedBorder: OutlineInputBorder(
        borderRadius: AppDesign.radius,
        borderSide: BorderSide(color: AppColors.primary, width: borderWith),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppDesign.radius,
        borderSide: BorderSide(color: AppColors.danger, width: borderWith),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppDesign.radius,
        borderSide: BorderSide(color: AppColors.danger, width: borderWith),
      ),
      outlineBorder: BorderSide(
        color: Colors.white.withValues(alpha: isLight ? 1 : 0.7),
        width: borderWith,
      ),
      disabledBorder: border,
      errorStyle: textTheme.labelSmall?.copyWith(
        color: AppColors.danger,
      ),
      hintStyle: textTheme.labelSmall?.copyWith(
        color:
            //  isLight
            // ?
            AppColors.grey.withValues(alpha: 0.6),
        // : "#F8F7FA".toColor(),
      ),
      labelStyle: textTheme.bodySmall,
    );
  }

  //! Dialogs & Cards ===============================================================================
  static final DialogThemeData dialogTheme = DialogThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: AppDesign.radiusLarge,
    ),
    backgroundColor: AppColors.surface,
  );

  static final CardThemeData cardTheme = CardThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: AppDesign.radius,
    ),
    elevation: 0,
    color: AppColors.card,
  );

  //! Icons & Checkbox ===============================================================================
  static final CheckboxThemeData checkBoxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.r),
    ),
    side:
        BorderSide(width: 1.5.sp, color: AppColors.grey.withValues(alpha: 0.4)),
    fillColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primary
          : Colors.transparent,
    ),
  );
}
