import '../../../../../common/imports/imports.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key, this.withPrefix = true});
  final bool withPrefix;
  @override
  Widget build(BuildContext context) {
    return CustomReactiveField(
      controller: InputKeys.email,
      keyboardType: TextInputType.emailAddress,
      title: AppString.email,
      prefixIcon: withPrefix ? TablerIcons.mail : null,
      hintText: "name@example.com",
    );
  }
}
