import '../../../../imports/imports.dart';

class CustomReactiveDropdown<T> extends StatelessWidget {
  const CustomReactiveDropdown({
    super.key,
    required this.controller,
    required this.items,
    this.title,
    this.hintText,
    this.prefixIcon,
    this.onChanged,
  });

  final String controller;
  final String? title;
  final String? hintText;
  final List<DropdownMenuItem<T>> items;
  final Widget? prefixIcon;
  final void Function(FormControl<T>)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) TitleWidget(title: title!),
        ReactiveDropdownField<T>(
          formControlName: controller,
          items: items,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
          ),
        ),
      ],
    );
  }
}
