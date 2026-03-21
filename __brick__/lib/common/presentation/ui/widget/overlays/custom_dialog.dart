import '../../../../imports/imports.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    this.headerIcon,
    required this.headerTitle,
    required this.body,
    this.primaryText,
    this.cancelText,
    this.onPrimaryTap,
    this.subTitleWidget,
    this.withCloseButton = true,
    this.isPrimaryLoading = false,
  });

  final Widget? headerIcon;
  final String headerTitle;
  final Widget body;
  final String? primaryText;
  final String? cancelText;
  final VoidCallback? onPrimaryTap;
  final Widget? subTitleWidget;
  final bool withCloseButton;
  final bool isPrimaryLoading;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: AppDesign.radiusLarge,
      ),
      insetPadding: REdgeInsets.symmetric(
        horizontal: AppDesign.horizontalPadding,
      ),
      child: Padding(
        padding: REdgeInsets.all(AppDesign.verticalPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (headerIcon != null) ...[
                  headerIcon!,
                  (AppDesign.horizontalPadding / 2).horizontalSpace,
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        headerTitle,
                        style: context.titleLarge,
                      ),
                      if (subTitleWidget != null) subTitleWidget!,
                    ],
                  ),
                ),
              ],
            ),
            AppDesign.verticalPadding.verticalSpace,
            body,
            (AppDesign.verticalPadding * 1.5).verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (withCloseButton) ...[
                  Expanded(
                    child: CustomButton.outlined(
                      isLoading: false,
                      onPressed: () => Navigator.of(context).pop(),
                      text: cancelText ?? AppString.close,
                    ),
                  ),
                  (AppDesign.horizontalPadding / 2).horizontalSpace,
                ],
                if (onPrimaryTap != null)
                  Expanded(
                    child: CustomButton.primary(
                      onPressed: onPrimaryTap,
                      isLoading: isPrimaryLoading,
                      text: primaryText ?? AppString.save,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
