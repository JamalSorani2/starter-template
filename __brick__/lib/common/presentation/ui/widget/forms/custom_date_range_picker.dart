import '../../../../imports/imports.dart';

class CustomReactiveDateRangePicker extends StatefulWidget {
  const CustomReactiveDateRangePicker({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.formGroup,
    this.onSelectDateRange,
  });

  final String title;
  final String hintText;
  final String controller;
  final FormGroup formGroup;
  final Function(DateTimeRange?)? onSelectDateRange;

  @override
  State<CustomReactiveDateRangePicker> createState() =>
      _CustomReactiveDateRangePickerState();
}

class _CustomReactiveDateRangePickerState
    extends State<CustomReactiveDateRangePicker> {
  DateTimeRange? selectedDateRange;

  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: selectedDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
        widget.formGroup.control(widget.controller).value = picked;
      });
      widget.onSelectDateRange?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    selectedDateRange = widget.formGroup.control(widget.controller).value;

    return ReactiveForm(
      formGroup: widget.formGroup,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(title: widget.title),
          ReactiveFormField<DateTimeRange, DateTimeRange>(
            formControlName: widget.controller,
            builder: (field) {
              return GestureDetector(
                onTap: _selectDateRange,
                child: Container(
                  height: AppDesign.inputHeight,
                  width: context.screenWidth,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDesign.inputContentPadding.left / 2,
                    vertical: AppDesign.inputContentPadding.vertical / 2,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          field.touched ? AppColors.danger : AppColors.border,
                    ),
                    borderRadius: AppDesign.radius,
                  ),
                  child: Row(
                    children: [
                      FieldIcon(Icons.date_range_outlined)!,
                      AppDesign.inputContentPadding.left.horizontalSpace,
                      if (selectedDateRange != null)
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                selectedDateRange!.formatDateRange(),
                                style: context.bodySmall.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDateRange = null;
                                    widget.formGroup
                                        .control(widget.controller)
                                        .value = null;
                                  });
                                  widget.onSelectDateRange?.call(null);
                                },
                                child: Icon(
                                  Icons.close,
                                  size: AppDesign.icon,
                                  color: AppColors.primary,
                                ),
                              ),
                              4.horizontalSpace,
                            ],
                          ),
                        )
                      else
                        Expanded(
                          child: Text(
                            widget.hintText,
                            style: context.hintText,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
