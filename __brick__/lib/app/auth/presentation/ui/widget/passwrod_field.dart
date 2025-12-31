// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

import '../../../../../common/imports/imports.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.isConfirmPassword,
    required this.hintText,
  });
  final bool isConfirmPassword;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return CustomReactiveField(
      controller:
          isConfirmPassword ? InputKeys.confirmPassword : InputKeys.password,
      prefixIcon: Icons.lock_outline,
      isPassword: true,
      asset: CupertinoIcons.eye_slash,
      suffixPassIcon: CupertinoIcons.eye,
      hintText: hintText,
      title: AppString.password,
    );
  }
}
