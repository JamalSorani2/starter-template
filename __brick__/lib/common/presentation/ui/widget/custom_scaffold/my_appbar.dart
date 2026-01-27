import '/common/imports/imports.dart';
import '../logo_widget.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
    required this.title,
    this.actions,
    this.titleWidget,
    this.isRoot,
  });
  final String title;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final bool? isRoot;

  @override
  Widget build(BuildContext context) {
    final isRoot = this.isRoot ??
        (context.route.endsWith(RoutesNames.root) ||
            context.route.contains(RoutesNames.dashboard));
    return Container(
      width: context.screenWidth,
      padding: EdgeInsets.only(top: context.paddingTop + 12.h),
      height: AppDesign.appBarHeight + context.paddingTop + 12.h,
      child: Column(
        children: [
          Row(
            children: [
              AppDesign.horizontalPadding.horizontalSpace,
              isRoot ? const LogoWidget() : const CustomBackButton(),
              12.horizontalSpace,
              Expanded(
                child: titleWidget ??
                    Text(
                      title,
                      style: context.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              12.horizontalSpace,
              if (actions != null)
                Row(
                  children: [
                    for (int index = 0; index < actions!.length; index++) ...[
                      actions![index],
                      if (index != actions!.length - 1) 8.horizontalSpace,
                    ],
                  ],
                ),
              AppDesign.horizontalPadding.horizontalSpace,
            ],
          ),
        ],
      ),
    );
  }
}
