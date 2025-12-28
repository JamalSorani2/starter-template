import '../../../../imports/imports.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        context.isLTR
            ? FontAwesomeIcons.arrowLeft
            : FontAwesomeIcons.arrowRight,
      ),
      onPressed: () {
        GoRouter.of(context).pop();
      },
    );
  }
}
