import '../../../../imports/imports.dart';

class CustomReactiveNumberField extends StatelessWidget {
  const CustomReactiveNumberField({
    super.key,
    required this.controller,
    this.title,
    this.hintText,
    this.readOnly = false,
    this.autoFocus = false,
    this.minLengthValidator,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.asset,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
  });

  final String controller;
  final String? title;
  final String? hintText;
  final bool readOnly;
  final bool autoFocus;
  final String? minLengthValidator;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;
  final Widget? asset;
  final Widget? suffixIcon;
  final void Function(FormControl)? onTap;
  final void Function(FormControl<dynamic>)? onChanged;
  final void Function(FormControl<dynamic>)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return CustomReactiveField(
      controller: controller,
      title: title,
      hintText: hintText,
      readOnly: readOnly,
      autoFocus: autoFocus,
      minLengthValidator: minLengthValidator,
      keyboardType: TextInputType.number,
      textDirection: TextDirection.ltr,
      onChanged: (p0) {
        if (p0.value != null) {
          String value = p0.value.toString();
          if (value.isNotEmpty) {
            value.replaceAll(',', '');
            final double? num = double.tryParse(value);
            if (num != null && num < 0) {
              value = (num * -1).toString();
            }
          }
          if (!readOnly) {
            onChanged?.call(p0);
          }
        }
      },
      textInputAction: textInputAction,
      prefixIcon: prefixIcon,
      asset: asset,
      suffixPassIcon: suffixIcon,
      onTap: onTap,
      onSubmitted: onSubmitted,
    );
  }
}
