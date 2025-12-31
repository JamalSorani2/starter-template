import '../../../../imports/imports.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? icon;
  final bool isDisabled;
  final ButtonStyle? style;

  const CustomButton._({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.isDisabled = false,
    this.style,
    super.key,
  });

  // ─────────────────────────────
  // Primary
  // ─────────────────────────────
  factory CustomButton.primary({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Widget? icon,
    bool isDisabled = false,
    Key? key,
  }) {
    return CustomButton._(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: icon,
      isDisabled: isDisabled,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: Size.fromHeight(AppDesign.buttonHeight),
        shape: RoundedRectangleBorder(borderRadius: AppDesign.radius),
      ),
      key: key,
    );
  }

  // ─────────────────────────────
  // Secondary
  // ─────────────────────────────
  factory CustomButton.secondary({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Widget? icon,
    bool isDisabled = false,
    Key? key,
  }) {
    return CustomButton._(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: icon,
      isDisabled: isDisabled,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
        minimumSize: Size.fromHeight(AppDesign.buttonHeight),
        shape: RoundedRectangleBorder(borderRadius: AppDesign.radius),
      ),
      key: key,
    );
  }

  // ─────────────────────────────
  // Danger
  // ─────────────────────────────
  factory CustomButton.danger({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Widget? icon,
    bool isDisabled = false,
    Key? key,
  }) {
    return CustomButton._(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: icon,
      isDisabled: isDisabled,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.danger,
        foregroundColor: Colors.white,
        minimumSize: Size.fromHeight(AppDesign.buttonHeight),
        shape: RoundedRectangleBorder(borderRadius: AppDesign.radius),
      ),
      key: key,
    );
  }

  // ─────────────────────────────
  // Outlined
  // ─────────────────────────────
  factory CustomButton.outlined({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Widget? icon,
    bool isDisabled = false,
    Key? key,
  }) {
    return CustomButton._(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: icon,
      isDisabled: isDisabled,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: isDisabled ? AppColors.border : AppColors.primary,
        ),
        minimumSize: Size.fromHeight(AppDesign.buttonHeight),
        shape: RoundedRectangleBorder(borderRadius: AppDesign.radius),
      ),
      key: key,
    );
  }

  @override
  Widget build(BuildContext context) {
    final childContent = isLoading
        ? LoadingProgress(
            color: AppColors.textPrimary,
            size: AppDesign.buttonHeight * 0.6,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                8.horizontalSpace,
              ],
              Flexible(child: Text(text)),
            ],
          );

    return ElevatedButton(
      style: style,
      onPressed: isDisabled
          ? null
          : isLoading
              ? () {}
              : onPressed,
      child: childContent,
    );
  }
}
