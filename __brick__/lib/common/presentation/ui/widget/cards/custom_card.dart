import '../../../../imports/imports.dart';

class CustomCard extends StatelessWidget {
  final Widget? header;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    this.header,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null) ...[
          header!,
          12.verticalSpace,
        ],
        child,
      ],
    );

    final card = Container(
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: content,
    );

    if (onTap != null) {
      return InkWell(onTap: onTap, child: card);
    }
    return card;
  }
}
