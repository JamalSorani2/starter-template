import '../imports/imports.dart';

extension TextThemeExtension on BuildContext {
  /// 57.sp — FontWeight.w400
  TextStyle get displayLarge => Theme.of(this).textTheme.displayLarge!;

  /// 45.sp — FontWeight.w400
  TextStyle get displayMedium => Theme.of(this).textTheme.displayMedium!;

  /// 36.sp — FontWeight.w400
  TextStyle get displaySmall => Theme.of(this).textTheme.displaySmall!;

  /// 32.sp — FontWeight.w400
  TextStyle get headlineLarge => Theme.of(this).textTheme.headlineLarge!;

  /// 28.sp — FontWeight.w400
  TextStyle get headlineMedium => Theme.of(this).textTheme.headlineMedium!;

  /// 24.sp — FontWeight.w400
  TextStyle get headlineSmall => Theme.of(this).textTheme.headlineSmall!;

  /// 22.sp — FontWeight.w400
  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!;

  /// 16.sp — FontWeight.w500
  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;

  /// 14.sp — FontWeight.w500
  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!;

  /// 16.sp — FontWeight.w400
  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;

  /// 14.sp — FontWeight.w400
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;

  /// 12.sp — FontWeight.w400
  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!;

  /// 14.sp — FontWeight.w500
  TextStyle get labelLarge => Theme.of(this).textTheme.labelLarge!;

  /// 12.sp — FontWeight.w500
  TextStyle get labelMedium => Theme.of(this).textTheme.labelMedium!;

  /// 11.sp — FontWeight.w500
  TextStyle get labelSmall => Theme.of(this).textTheme.labelSmall!;

  /// 12.sp — FontWeight.w400
  TextStyle get hintText => bodySmall.copyWith(color: AppColors.textDisabled);
}
