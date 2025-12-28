import 'package:dotted_border/dotted_border.dart';

import '../../../imports/imports.dart';

class CustomDottedBorder extends StatelessWidget {
  const CustomDottedBorder({
    super.key,
    this.color,
    this.padding,
    required this.child,
  });

  final Widget child;
  final Color? color;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      child: Padding(
        padding: padding ?? REdgeInsets.all(8),
        child: child,
      ),
    );
  }
}
