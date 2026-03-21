import '../../../../imports/imports.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        context.isLTR ? TablerIcons.chevron_left : TablerIcons.chevron_right,
      ),
      onPressed: () {
        GoRouter.of(context).pop();
      },
    );
  }
}
