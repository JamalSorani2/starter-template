// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

import '../../../../../common/imports/imports.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    this.isConfirmPassword = false,
    this.withTitle = false,
    required this.hintText,
    this.onSubmit,
    this.textInputAction = TextInputAction.next,
  });
  final bool isConfirmPassword;
  final String hintText;
  final bool withTitle;
  final VoidCallback? onSubmit;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return CustomReactiveField(
      controller:
          isConfirmPassword ? InputKeys.confirmPassword : InputKeys.password,
      prefixIcon: TablerIcons.lock_filled,
      isPassword: true,
      asset: CupertinoIcons.eye_slash_fill,
      suffixPassIcon: CupertinoIcons.eye_fill,
      hintText: hintText,
      title: withTitle ? AppString.password : null,
      onSubmitted: (value) => onSubmit?.call(),
      keyboardType: TextInputType.visiblePassword,
      textInputAction: textInputAction,
    );
  }
}
