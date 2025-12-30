import '../../../imports/imports.dart';

class CloseKeyboardOntapOutside extends StatelessWidget {
  const CloseKeyboardOntapOutside({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}
