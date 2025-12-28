import '../../../imports/imports.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.margin,
    this.color,
    this.height,
    this.width,
    this.isVertical = false,
  });
  final EdgeInsets? margin;
  final Color? color;
  final double? height;
  final double? width;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: isVertical ? 1 : 0,
      child: Container(
        height: height ?? 1,
        margin: margin,
        width: width ?? context.screenWidth,
        color: color ?? AppColors.border,
      ),
    );
  }
}
