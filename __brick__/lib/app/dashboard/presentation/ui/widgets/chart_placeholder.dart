import '../../../../../../common/imports/imports.dart';

class ChartPlaceholder extends StatelessWidget {
  final String title;
  const ChartPlaceholder({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      header: Text(title, style: Theme.of(context).textTheme.titleMedium),
      child: SizedBox(
        height: 220.h,
        child: Center(
          child: Text(
            'Add your chart widget here',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
      ),
    );
  }
}
