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
    final isRoot = context.route.endsWith(RoutesNames.root);
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
              isRoot ? const DrawerButton() : const BackButton(),
              Expanded(
                child: titleWidget ??
                    Text(
                      title,
                      style: context.s22w400,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              if (actions != null)
                Row(
                  children: [
                    for (int index = 0; index < actions!.length; index++) ...[
                      actions![index],
                      if (index != actions!.length - 1) 8.horizontalSpace,
                    ],
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
