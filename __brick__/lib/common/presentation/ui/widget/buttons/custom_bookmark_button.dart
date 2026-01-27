import '../../../../imports/imports.dart';

class CustomBookmarkButton extends StatefulWidget {
  const CustomBookmarkButton({
    super.key,
    required this.isSaved,
    required this.onChanged,
    this.isDisabled = false,
    this.color,
    this.count = 0, // added
  });

  final bool isSaved;
  final ValueChanged<bool> onChanged;
  final bool isDisabled;
  final Color? color;
  final int count; // number of saved items

  @override
  State<CustomBookmarkButton> createState() => _CustomBookmarkButtonState();
}

class _CustomBookmarkButtonState extends State<CustomBookmarkButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      lowerBound: 0.9,
      upperBound: 1.1,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (widget.isDisabled) {
      return;
    }

    _controller.forward().then((_) => _controller.reverse());
    widget.onChanged(!widget.isSaved);
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ??
        (widget.isDisabled ? AppColors.textDisabled : AppColors.primary);

    return Tooltip(
      message: widget.isDisabled
          ? null
          : widget.isSaved
              ? AppString.removeFromFavorites
              : AppString.addToFavorites,
      child: GestureDetector(
        onTap: _toggle,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: AppDesign.icon + 8.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ScaleTransition(
                scale: _controller,
                child: Icon(
                  widget.isSaved
                      ? TablerIcons.bookmark_filled
                      : TablerIcons.bookmark,
                  size: AppDesign.icon,
                  color: color,
                ),
              ),
              Positioned(
                top: 14.h,
                child: Container(
                  height: 1.h,
                  width: 4.w,
                  color: widget.isSaved ? AppColors.card : color,
                ),
              ),

              // count badge
              if (widget.count > 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: REdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.count.toString(),
                      style: context.labelSmall.copyWith(
                        color: Colors.white,
                        fontSize: 8.sp,
                        // fontSize: 5.sp,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
