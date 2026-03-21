import '../../../../../common/imports/imports.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.isConfirmPassword,
    this.title,
    this.withPrefix = true,
    this.hintText,
    this.overrideControl,
  });
  final bool isConfirmPassword;
  final bool withPrefix;
  final String? title;
  final String? overrideControl;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return CustomReactiveField(
      controller: overrideControl ??
          (isConfirmPassword ? InputKeys.confirmPassword : InputKeys.password),
      prefixIcon: withPrefix ? TablerIcons.lock : null,
      isPassword: true,
      asset: TablerIcons.eye_off,
      suffixPassIcon: TablerIcons.eye,
      hintText: hintText ?? "********",
      title: title ?? AppString.password,
    );
  }
}
