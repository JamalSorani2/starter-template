import '../../../../imports/imports.dart';

class AnimatedPositionedCircles extends StatefulWidget {
  const AnimatedPositionedCircles({super.key, required this.isEnglish});
  final bool isEnglish;

  @override
  State<AnimatedPositionedCircles> createState() =>
      _AnimatedPositionedCirclesState();
}

class _AnimatedPositionedCirclesState extends State<AnimatedPositionedCircles>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _topSlide;
  late final Animation<Offset> _bottomSlide;
  late final Animation<double> _fade;

  // Floating animation
  late final AnimationController _floatController;
  late final Animation<double> _topFloatX;
  late final Animation<double> _topFloatY;
  late final Animation<double> _bottomFloatX;
  late final Animation<double> _bottomFloatY;
  @override
  void initState() {
    super.initState();
    // ===== Entrance Animation =====
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _topSlide = Tween<Offset>(begin: const Offset(0, -0.3), end: Offset.zero)
        .animate(curve);
    _bottomSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(curve);
    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 1)),
    );

    _controller.forward();

    // ===== Floating Animation =====
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Top circles: up + right/left
    _topFloatX = Tween<double>(
      begin: 0,
      end: widget.isEnglish ? 7 : -7,
    ).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _topFloatY = Tween<double>(
      begin: 0,
      end: -7,
    ).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Bottom circles: down + left/right
    _bottomFloatX = Tween<double>(
      begin: 0,
      end: widget.isEnglish ? -7 : 7,
    ).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _bottomFloatY = Tween<double>(
      begin: 0,
      end: 7,
    ).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _floatController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //! Top circles
        _AnimatedPositionedCircle(
          top: -100.h,
          left: widget.isEnglish ? null : 0,
          right: widget.isEnglish ? 0 : null,
          size: 160.r,
          slideAnimation: _topSlide,
          fadeAnimation: _fade,
          floatXAnimation: _topFloatX,
          floatYAnimation: _topFloatY,
        ),
        _AnimatedPositionedCircle(
          top: -40.h,
          left: widget.isEnglish ? null : -80.w,
          right: widget.isEnglish ? -80.w : null,
          size: 160.r,
          slideAnimation: _topSlide,
          fadeAnimation: _fade,
          floatXAnimation: _topFloatX,
          floatYAnimation: _topFloatY,
        ),

        //! Bottom circles
        _AnimatedPositionedCircle(
          bottom: -100.h,
          left: widget.isEnglish ? 0 : null,
          right: widget.isEnglish ? null : 0,
          size: 160.r,
          slideAnimation: _bottomSlide,
          fadeAnimation: _fade,
          floatXAnimation: _bottomFloatX,
          floatYAnimation: _bottomFloatY,
        ),
        _AnimatedPositionedCircle(
          bottom: -40.h,
          left: widget.isEnglish ? -80.w : null,
          right: widget.isEnglish ? null : -80.w,
          size: 160.r,
          slideAnimation: _bottomSlide,
          fadeAnimation: _fade,
          floatXAnimation: _bottomFloatX,
          floatYAnimation: _bottomFloatY,
        ),
      ],
    );
  }
}

class _CircleWithPrimaryColor extends StatelessWidget {
  const _CircleWithPrimaryColor({
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        gradient: AppGradients.primary,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _AnimatedPositionedCircle extends StatelessWidget {
  const _AnimatedPositionedCircle({
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.size,
    required this.slideAnimation,
    required this.fadeAnimation,
    required this.floatXAnimation,
    required this.floatYAnimation,
  });

  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final double size;
  final Animation<Offset> slideAnimation;
  final Animation<double> fadeAnimation;
  final Animation<double> floatXAnimation;
  final Animation<double> floatYAnimation;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: AnimatedBuilder(
            animation: Listenable.merge([floatXAnimation, floatYAnimation]),
            builder: (_, child) {
              return Transform.translate(
                offset: Offset(floatXAnimation.value, floatYAnimation.value),
                child: child,
              );
            },
            child: _CircleWithPrimaryColor(size: size),
          ),
        ),
      ),
    );
  }
}
