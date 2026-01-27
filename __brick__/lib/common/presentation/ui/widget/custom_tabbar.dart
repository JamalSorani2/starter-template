import '../../../imports/imports.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.titles,
    required this.pageIndexProvider,
    this.icon,
  });
  final List<String> titles;
  final PageIndexProvider pageIndexProvider;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final height = 40.h;
    return SizedBox(
      height: height,
      width: context.screenWidth,
      child: Consumer<PageIndexProvider>(
        builder: (context, pageIndexProvider, child) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: AppDesign.horizentalEdgeInsets,
            itemCount: titles.length,
            itemBuilder: (context, index) {
              final title = titles[index];
              final isSelected = index == pageIndexProvider.pageIndex;
              final textColor = isSelected ? Colors.white : AppColors.primary;
              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      pageIndexProvider.updatePageIndex(index);
                    },
                    child: Container(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: AppDesign.radiusLarge,
                        color:
                            isSelected ? AppColors.primary : Colors.transparent,
                        border: Border.all(color: AppColors.primary),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (icon != null) ...[
                            Icon(
                              icon,
                              size: 12.sp,
                              color: textColor,
                            ),
                            8.horizontalSpace,
                          ],
                          Text(
                            title,
                            style: context.labelMedium.copyWith(
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (index < titles.length - 1) 8.horizontalSpace,
                ],
              );
            },
          );
        },
      ),
    );
  }
}
