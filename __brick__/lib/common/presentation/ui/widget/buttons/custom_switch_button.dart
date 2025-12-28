import '../../../../imports/imports.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: context.s12w500.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        8.horizontalSpace,
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: AppColors.primary,
          inactiveThumbColor: AppColors.surface,
          inactiveTrackColor: AppColors.border,
        ),
      ],
    );
  }
}
