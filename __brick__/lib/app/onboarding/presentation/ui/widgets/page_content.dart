import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../common/imports/imports.dart';

class OnBoardingPageData {
  final String title;
  final String description1;
  final String description2;
  final String pic;

  OnBoardingPageData({
    required this.title,
    required this.description1,
    required this.description2,
    required this.pic,
  });
}

class PageContent extends StatelessWidget {
  const PageContent({
    super.key,
    required this.colorController,
    required this.page,
    required this.pageIndex,
  });

  final bool colorController;
  final OnBoardingPageData page;
  final int pageIndex;
  @override
  Widget build(BuildContext context) {
    final width = [
      265.sp,
      236.sp,
      255.sp,
    ];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomSvgPicture(
          //   height: 346.h,
          //   width: 314.w,
          //   image: page.pic,
          // ).animate().shimmer(
          //       duration: const Duration(milliseconds: 1500),
          //       color: Colors.white.withValues(alpha: 0.3),
          //     ),
          // 32.verticalSpace,
          // Text(
          //   page.title,
          //   style: context.s32w400.copyWith(
          //     color: AppColors.grey.withValues(alpha: 0.8),
          //   ),
          // ).animate().shimmer(
          //       duration: const Duration(milliseconds: 1500),
          //       color: Colors.white.withValues(alpha: 0.3),
          //     ),
          24.verticalSpace,
          Text(
            page.description1,
            style: context.displayLarge.copyWith(
              color: AppColors.grey.withValues(alpha: 0.9),
            ),
          ).animate().shimmer(
                duration: const Duration(milliseconds: 1500),
                color: Colors.white.withValues(alpha: 0.3),
              ),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: width[pageIndex],
                height: 10.sp,
                color: AppColors.secondary,
              ),
              Text(
                page.description2,
                style: context.displayLarge.copyWith(
                  color: AppColors.grey.withValues(alpha: 0.9),
                ),
              ),
            ],
          ).animate().shimmer(
                duration: const Duration(milliseconds: 1500),
                color: Colors.white.withValues(alpha: 0.3),
              ),
        ],
      ),
    );
  }
}
