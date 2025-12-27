import '../../../../imports/imports.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    required this.controller,
    this.hintText,
    required this.onSubmitted,
    this.readOnly = false,
    this.autoFocus = false,
  });

  final String controller;
  final String? hintText;
  final void Function(FormControl<dynamic>) onSubmitted;
  final bool readOnly;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return CustomReactiveField(
      controller: controller,
      hintText: hintText ?? AppString.search,
      readOnly: readOnly,
      autoFocus: autoFocus,
      textInputAction: TextInputAction.search,
      prefixIcon: const Icon(Icons.search),
      onSubmitted: onSubmitted,
    );
  }
}
