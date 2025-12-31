import '../../../../../../common/imports/imports.dart';

class ListPlaceholder extends StatelessWidget {
  final String title;
  const ListPlaceholder({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      header: Text(title, style: Theme.of(context).textTheme.titleMedium),
      child: Column(
        children: List.generate(
          5,
          (i) => Padding(
            padding: REdgeInsets.symmetric(vertical: 8.r),
            child: Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 10.h, color: AppColors.border),
                      SizedBox(height: 6.h),
                      Container(
                        height: 10.h,
                        width: 120.w,
                        color: AppColors.border,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
