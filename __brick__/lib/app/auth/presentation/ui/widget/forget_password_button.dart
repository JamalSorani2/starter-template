import '../../../../../../common/imports/imports.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({super.key, required this.onTap});
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                TablerIcons.info_circle,
                size: 16.sp,
              ),
              8.horizontalSpace,
              Text(
                AppString.forgotPasswordTitle,
                style: context.bodySmall.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.grey.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
