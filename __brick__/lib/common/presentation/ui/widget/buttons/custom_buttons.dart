import '../../../../imports/imports.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? icon;
  final bool isDisabled;
  final double? fontSize;

  final Gradient? gradient;
  final Color? solidColor;
  final BorderSide? border;
  final double? height;
  final bool isGradient;
  final BorderRadius? borderRadius;

  const CustomButton._({
    required this.text,
    required this.textColor,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.isDisabled = false,
    this.isGradient = true,
    this.fontSize,
    this.gradient,
    this.solidColor,
    this.border,
    this.height,
    this.borderRadius,
    super.key,
  });

  // ─────────────────────────────
  // Primary (Gradient)
  // ─────────────────────────────
  factory CustomButton.primary({
    required String text,
    required VoidCallback? onPressed,
    required bool isLoading,
    Widget? icon,
    bool isDisabled = false,
    bool isGradient = true,
    Key? key,
    double? fontSize,
    double? height,
    BorderRadius? borderRadius,
  }) {
    return CustomButton._(
      text: text,
      textColor: Colors.white,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: icon,
      isDisabled: isDisabled,
      fontSize: fontSize,
      gradient: isGradient ? AppGradients.primary : null,
      solidColor: isGradient ? null : AppColors.primary.withValues(alpha: 0.8),
      height: height,
      isGradient: isGradient,
      borderRadius: borderRadius,
      key: key,
    );
  }

  // ─────────────────────────────
  // Secondary (Gradient)
  // ─────────────────────────────
  factory CustomButton.secondary({
    required String text,
    required VoidCallback? onPressed,
    required bool isLoading,
    Widget? icon,
    bool isDisabled = false,
    Key? key,
    double? fontSize,
    double? height,
  }) {
    return CustomButton._(
      text: text,
      textColor: AppColors.onSecondary,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: icon,
      isDisabled: isDisabled,
      fontSize: fontSize,
      gradient: AppGradients.secondary,
      height: height,
      key: key,
    );
  }

  // ─────────────────────────────
  // Danger (Gradient)
  // ─────────────────────────────
  factory CustomButton.danger({
    required String text,
    required VoidCallback? onPressed,
    required bool isLoading,
    Widget? icon,
    bool isDisabled = false,
    Key? key,
    double? fontSize,
    double? height,
    BorderRadius? borderRadius,
  }) {
    return CustomButton._(
      text: text,
      textColor: Colors.white,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: icon,
      isDisabled: isDisabled,
      fontSize: fontSize,
      gradient: AppGradients.danger,
      height: height,
      borderRadius: borderRadius,
      key: key,
    );
  }

  // ─────────────────────────────
  // Outlined
  // ─────────────────────────────
  factory CustomButton.outlined({
    required String text,
    required VoidCallback? onPressed,
    required bool isLoading,
    Widget? icon,
    bool isDisabled = false,
    Color? color,
    Color? textColor,
    Key? key,
    double? fontSize,
    double? height,
    BorderRadius? borderRadius,
  }) {
    return CustomButton._(
      text: text,
      textColor: textColor ?? AppColors.textPrimary,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: icon,
      isDisabled: isDisabled,
      fontSize: fontSize,
      solidColor: Colors.transparent,
      border: BorderSide(
        color: isDisabled
            ? AppColors.textDisabled
            : color ?? AppColors.textPrimary,
      ),
      borderRadius: borderRadius,
      height: height,
      key: key,
    );
  }

  // ─────────────────────────────
  // BUILD
  // ─────────────────────────────
  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? AppDesign.radiusLarge;

    final childContent = isLoading
        ? LoadingProgress(
            color: textColor,
            size: (height ?? AppDesign.buttonHeight) * 0.6,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  text,
                  style: context.bodySmall.copyWith(
                    color: isDisabled ? AppColors.textDisabled : textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize,
                  ),
                ),
              ),
              if (icon != null) ...[
                8.horizontalSpace,
                icon!,
              ],
            ],
          );

    return Opacity(
      opacity: isDisabled ? 0.6 : 1,
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: Ink(
          height: height ?? AppDesign.buttonHeight,
          decoration: BoxDecoration(
            gradient: gradient,
            color: solidColor,
            borderRadius: borderRadius,
            border: border == null ? null : Border.fromBorderSide(border!),
          ),
          child: InkWell(
            borderRadius: borderRadius,
            onTap: isDisabled || isLoading ? null : onPressed,
            child: Center(child: childContent),
          ),
        ),
      ),
    );
  }
}
