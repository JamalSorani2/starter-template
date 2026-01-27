import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';

import '../../../../imports/imports.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    super.key,
    required this.controller,
    this.title,
    this.hintText,
    this.fillColor,
    this.type = ReactiveDatePickerFieldType.date,
    this.format,
    this.minTime,
    this.maxTime,
  });

  final String controller;
  final String? title;
  final String? hintText;
  final Color? fillColor;
  final ReactiveDatePickerFieldType type;
  final DateFormat? format;
  final DateTime? minTime;
  final DateTime? maxTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) TitleWidget(title: title!),
        ReactiveDateTimePicker(
          formControlName: controller,
          locale: const Locale("en"),
          type: type,
          dateFormat: format ?? kDateFormat,
          style: context.bodySmall,
          firstDate: minTime,
          lastDate: maxTime,
          decoration: InputDecoration(
            prefixIcon: FieldIcon(TablerIcons.clock),
            hintText: hintText,
            fillColor: fillColor,
          ),
        ),
      ],
    );
  }
}
