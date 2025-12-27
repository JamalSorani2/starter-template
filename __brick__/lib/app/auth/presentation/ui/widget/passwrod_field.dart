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
      prefixIcon: Icon(
        Icons.lock_outline,
        color: AppColors.grey.withValues(alpha: 0.5),
        size: 24.sp,
      ),
      isPassword: true,
      asset: Icon(
        CupertinoIcons.eye_slash,
        color: AppColors.grey.withValues(alpha: 0.5),
        size: 24.sp,
      ),
      suffixPassIcon: Icon(
        CupertinoIcons.eye,
        color: AppColors.grey.withValues(alpha: 0.5),
        size: 24.sp,
      ),
      hintText: hintText,
    );
  }
}
