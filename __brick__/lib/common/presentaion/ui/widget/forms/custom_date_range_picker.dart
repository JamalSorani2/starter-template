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
          if (widget.title.isNotEmpty)
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 4.r),
              child: Text(
                widget.title,
                style: context.s16w500,
              ),
            ),
          8.verticalSpace,
          ReactiveFormField<DateTimeRange, DateTimeRange>(
            formControlName: widget.controller,
            builder: (field) {
              return InkWell(
                onTap: _selectDateRange,
                child: Container(
                  height: AppDesign.inputHeight,
                  width: context.screenWidth,
                  padding: AppDesign.inputContentPadding,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          field.touched ? AppColors.danger : AppColors.border,
                    ),
                    borderRadius: AppDesign.radius,
                  ),
                  child: Row(
                    children: [
                      if (selectedDateRange != null)
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                selectedDateRange!.formatDateRange(),
                                style: context.s12w400.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
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
                                  color: AppColors.textPrimary,
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
                            style: context.s12w400.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      Icon(
                        Icons.date_range_outlined,
                        color: AppColors.textPrimary,
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
