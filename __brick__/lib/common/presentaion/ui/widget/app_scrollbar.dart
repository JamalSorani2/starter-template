import 'package:app_name/common/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppScrollbar extends StatelessWidget {
  const AppScrollbar({
    super.key,
    required this.child,
    this.controller,
    this.thickness,
    this.radius,
    this.isAlwaysShown = true,
  });

  final Widget child;
  final ScrollController? controller;
  final double? thickness;
  final double? radius;
  final bool isAlwaysShown;

  @override
  Widget build(BuildContext context) {
    final isLTR = context.isLTR;

    return Scrollbar(
      controller: controller,
      thumbVisibility: isAlwaysShown,
      trackVisibility: false,
      radius: Radius.circular(radius ?? 8.r),
      thickness: thickness ?? 8.r,
      interactive: true,
      scrollbarOrientation:
          isLTR ? ScrollbarOrientation.left : ScrollbarOrientation.right,
      child: child,
    );
  }
}
