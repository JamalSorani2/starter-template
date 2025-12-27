import '../../../../../common/imports/imports.dart';

class BackToLoginButton extends StatelessWidget {
  const BackToLoginButton({super.key, this.title, this.onPressed});
  final String? title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomButton.outlined(
      text: title ?? AppString.backToLoginButton,
      icon: Icon(
        context.isEnglish
            ? FontAwesomeIcons.chevronLeft
            : FontAwesomeIcons.chevronRight,
      ),
      onPressed: onPressed ??
          () {
            context.replace(RoutesNames.login);
          },
    );
  }
}
