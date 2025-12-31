import '../../../../../common/imports/imports.dart';

class UsernameField extends StatelessWidget {
  const UsernameField({
    super.key,
    this.withTitle = false,
    this.readOnly = false,
  });
  final bool withTitle;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return CustomReactiveField(
      controller: InputKeys.username,
      title: withTitle ? AppString.userName : null,
      readOnly: readOnly,
      hintText: AppString.userName,
      minLengthValidator: AppString.userNameMinLength,
      prefixIcon: FontAwesomeIcons.user,
    );
  }
}
