import '../../../../../common/imports/imports.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomReactiveField(
      controller: InputKeys.email,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icon(
        Icons.email_outlined,
        color: AppColors.grey.withValues(alpha: 0.5),
        size: 24.sp,
      ),
      hintText: AppString.email,
    );
  }
}
