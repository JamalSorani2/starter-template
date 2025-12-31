import '../../../../../../common/imports/imports.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  const ResponsiveGrid({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        int columns = 1;
        if (width >= 1200) {
          columns = 4; // desktop
        } else if (width >= 800) {
          columns = 2; // tablet
        }
        final itemWidth =
            (width - (AppDesign.horizontalPadding.w * (columns - 1))) / columns;

        return Wrap(
          spacing: AppDesign.horizontalPadding.w,
          runSpacing: AppDesign.verticalPadding.h,
          children: children
              .map((e) => SizedBox(width: itemWidth, child: e))
              .toList(),
        );
      },
    );
  }
}
