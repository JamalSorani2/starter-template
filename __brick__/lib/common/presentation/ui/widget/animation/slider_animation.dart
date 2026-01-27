import '../../../../imports/imports.dart';

class SlideInAnimation extends StatefulWidget {
  const SlideInAnimation({
    super.key,
    required this.child,
    required this.index,
  });

  final Widget child;
  final int index;

  @override
  State<SlideInAnimation> createState() => _SlideInAnimationState();
}

class _SlideInAnimationState extends State<SlideInAnimation>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Speed of the slide
    );

    // Slide from Right (1.0) to Center (0.0)
    _animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutQuart, // Smooth ease out
      ),
    );

    // ANIMATION LOGIC:
    // 1. If it's one of the first few items (e.g., index < 6), we stagger them
    //    so they fill the screen one by one.
    // 2. If it's a later item (index >= 6), we assume the user is scrolling,
    //    so we trigger it immediately (with a tiny delay to ensure build).

    final delay = widget.index * 100;

    Future.delayed(Duration(milliseconds: delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
