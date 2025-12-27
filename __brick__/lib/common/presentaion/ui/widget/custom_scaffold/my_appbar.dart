import '/common/imports/imports.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
    required this.title,
    this.actions,
    this.titleWidget,
  });
  final String title;
  final Widget? actions;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    final isRoot = context.route.endsWith(RoutesNames.root);
    return Container(
      width: context.screenWidth,
      height: AppDesign.appBarHeight,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.only(
          bottomLeft: AppDesign.radius.bottomLeft,
          bottomRight: AppDesign.radius.bottomRight,
        ),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          isRoot ? const DrawerButton() : const BackButton(),
          12.horizontalSpace,
          Expanded(
            child: titleWidget ??
                Text(
                  title,
                  style: context.s22w400,
                  overflow: TextOverflow.ellipsis,
                ),
          ),
          actions ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
