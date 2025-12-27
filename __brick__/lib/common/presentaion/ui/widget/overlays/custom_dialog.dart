import '../../../../imports/imports.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    this.headerIcon,
    required this.headerTitle,
    required this.body,
    this.primaryText,
    this.onPrimaryTap,
  });

  final Widget? headerIcon;
  final String headerTitle;
  final Widget body;
  final String? primaryText;
  final VoidCallback? onPrimaryTap;

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
                  child: Text(
                    headerTitle,
                    style: context.s22w400,
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
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(AppString.close),
                ),
                (AppDesign.horizontalPadding / 2).horizontalSpace,
                if (onPrimaryTap != null)
                  CustomButton.primary(
                    onPressed: onPrimaryTap,
                    text: primaryText ?? AppString.save,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
