import '../../../../imports/imports.dart';

class CustomRadioButton<T> extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
    this.isDisabled = false,
  });

  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final String label;
  final bool isDisabled;

  bool get _isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : () => onChanged(value),
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: AppDesign.horizentalEdgeInsets,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleText(
              label,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: 18.r,
              height: 18.r,
              padding: REdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary,
                  width: 2.w,
                ),
              ),
              child: _isSelected
                  ? Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
