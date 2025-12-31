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
      padding: REdgeInsets.all(4),
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
    labelStyle: TextStyle(color: AppColors.textPrimary),
  );

  //! Inputs ===============================================================================
  static InputDecorationTheme inputDecorationThemeLight(bool isEnglish) {
    final textTheme = AppTheme.textTheme(isEnglish);

    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: AppDesign.inputContentPadding,
      border: OutlineInputBorder(
        borderRadius: AppDesign.radius,
        borderSide: BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppDesign.radius,
        borderSide: BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppDesign.radius,
        borderSide: BorderSide(color: AppColors.primary),
      ),
      errorStyle: textTheme.labelSmall?.copyWith(
        color: AppColors.danger,
      ),
      hintStyle: textTheme.bodySmall?.copyWith(color: AppColors.textDisabled),
      labelStyle: textTheme.bodySmall,
    );
  }

  static InputDecorationTheme inputDecorationThemeDark(bool isEnglish) {
    final textTheme = AppTheme.textTheme(isEnglish);
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: AppDesign.inputContentPadding,
      border: OutlineInputBorder(
        borderRadius: AppDesign.radius,
        borderSide: BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppDesign.radius,
        borderSide: BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppDesign.radius,
        borderSide: BorderSide(color: AppColors.primary),
      ),
      hintStyle: textTheme.bodySmall?.copyWith(color: AppColors.textDisabled),
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
    fillColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primary
          : AppColors.border,
    ),
  );
}
