import '../../../../../common/imports/imports.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomReactiveField(
      controller: InputKeys.email,
      keyboardType: TextInputType.emailAddress,
      title: AppString.email,
      prefixIcon: Icons.email_outlined,
      hintText: AppString.email,
    );
  }
}
