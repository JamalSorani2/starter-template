import '/common/imports/imports.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
    required this.title,
    this.actions,
    this.titleWidget,
  });
  final String title;
  final List<Widget>? actions;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    final isRoot = context.route.endsWith(RoutesNames.root) ||
        context.route.contains(RoutesNames.dashboard);
    return Container(
      width: context.screenWidth,
      padding: EdgeInsets.only(top: context.paddingTop),
      height: AppDesign.appBarHeight + context.paddingTop,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.only(
          bottomLeft: AppDesign.radius.bottomLeft,
          bottomRight: AppDesign.radius.bottomRight,
        ),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        children: [
          Row(
            children: [
              AppDesign.horizontalPadding.horizontalSpace,
              isRoot ? const CustomDrawerButton() : const CustomBackButton(),
              12.horizontalSpace,
              Expanded(
                child: titleWidget ??
                    Text(
                      title,
                      style: context.s22w400,
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
