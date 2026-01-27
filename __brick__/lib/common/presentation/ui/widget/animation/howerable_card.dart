import '../../../../imports/imports.dart';

class HowerableCard extends StatefulWidget {
  const HowerableCard({super.key, required this.child, required this.onTap});
  final Widget child;
  final void Function() onTap;

  @override
  State<HowerableCard> createState() => _HowerableCardState();
}

class _HowerableCardState extends State<HowerableCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final hoverScale = _isHovered ? 1.05 : 0.97;
    final pressScale = _isPressed ? 0.97 : 1.05;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
        },
        onTap: widget.onTap,
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: hoverScale * pressScale,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
