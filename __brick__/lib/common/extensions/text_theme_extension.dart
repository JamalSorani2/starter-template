import '../imports/imports.dart';

extension TextThemeExtension on BuildContext {
  /// 57.sp — FontWeight.w400
  TextStyle get s57w400 => Theme.of(this).textTheme.displayLarge!;

  /// 45.sp — FontWeight.w400
  TextStyle get s45w400 => Theme.of(this).textTheme.displayMedium!;

  /// 36.sp — FontWeight.w400
  TextStyle get s36w400 => Theme.of(this).textTheme.displaySmall!;

  /// 32.sp — FontWeight.w400
  TextStyle get s32w400 => Theme.of(this).textTheme.headlineLarge!;

  /// 28.sp — FontWeight.w400
  TextStyle get s28w400 => Theme.of(this).textTheme.headlineMedium!;

  /// 24.sp — FontWeight.w400
  TextStyle get s24w400 => Theme.of(this).textTheme.headlineSmall!;

  /// 22.sp — FontWeight.w400
  TextStyle get s22w400 => Theme.of(this).textTheme.titleLarge!;

  /// 16.sp — FontWeight.w500
  TextStyle get s16w500 => Theme.of(this).textTheme.titleMedium!;

  /// 14.sp — FontWeight.w500
  TextStyle get s14w500 => Theme.of(this).textTheme.titleSmall!;

  /// 16.sp — FontWeight.w400
  TextStyle get s16w400 => Theme.of(this).textTheme.bodyLarge!;

  /// 14.sp — FontWeight.w400
  TextStyle get s14w400 => Theme.of(this).textTheme.bodyMedium!;

  /// 12.sp — FontWeight.w400
  TextStyle get s12w400 => Theme.of(this).textTheme.bodySmall!;

  // /// 14.sp — FontWeight.w500
  // TextStyle get labelLarge => Theme.of(this).textTheme.labelLarge!;

  /// 12.sp — FontWeight.w500
  TextStyle get s12w500 => Theme.of(this).textTheme.labelMedium!;

  /// 11.sp — FontWeight.w500
  TextStyle get s11w500 => Theme.of(this).textTheme.labelSmall!;

  /// 12.sp — FontWeight.w400
  TextStyle get hintText => s12w400.copyWith(color: AppColors.textDisabled);
}
