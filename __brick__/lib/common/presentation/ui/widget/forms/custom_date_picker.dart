import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import '../../../../imports/imports.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    super.key,
    required this.controller,
    this.title,
  });
  final String controller;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) TitleWidget(title: title!),
        ReactiveDateTimePicker(
          formControlName: controller,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.date_range_outlined),
          ),
        ),
      ],
    );
  }
}
