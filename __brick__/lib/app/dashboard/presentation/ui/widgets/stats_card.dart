import '../../../../../../common/imports/imports.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      header: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          8.horizontalSpace,
          Text(title, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
      child: Text(
        value,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
