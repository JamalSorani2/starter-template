import '../../../../../../common/imports/imports.dart';

class BackToLoginButton extends StatelessWidget {
  const BackToLoginButton({super.key, this.title, this.onPressed});
  final String? title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: Text(
        title ?? AppString.backToLoginButton,
        style: context.labelMedium.copyWith(
          fontSize: 13.sp,
          color: AppColors.secondary,
        ),
      ),
      icon: Icon(
        context.isEnglish
            ? TablerIcons.chevron_left
            : TablerIcons.chevron_right,
        color: AppColors.secondary,
      ),
      onPressed: onPressed ??
          () {
            context.replaceNamed(RoutesNames.login);
          },
    );
  }
}
