import '../../../../imports/imports.dart';

class DropDownModel {
  final String id;
  final String name;

  DropDownModel({required this.id, required this.name});
}

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
  final List<DropDownModel> items;
  final IconData? prefixIcon;
  final void Function(FormControl<T>)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) TitleWidget(title: title!),
        SafeArea(
          top: false,
          bottom: false,
          child: ReactiveDropdownField<T>(
            formControlName: controller,
            dropdownColor: AppColors.textDisabled,
            items: items
                .map(
                  (item) => DropdownMenuItem(
                    value: item.id as T,
                    child: Text(
                      item.name,
                      style: context.bodySmall,
                    ),
                  ),
                )
                .toList(),
            hint: Text(hintText ?? '', style: context.hintText),
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: FieldIcon(prefixIcon),
              suffixIconColor: AppColors.textDisabled,
            ),
          ),
        ),
      ],
    );
  }
}
