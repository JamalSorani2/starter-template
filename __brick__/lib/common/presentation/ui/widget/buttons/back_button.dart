import '../../../../imports/imports.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Directionality(
        textDirection: context.isLTR ? TextDirection.ltr : TextDirection.rtl,
        child: const Icon(
          FontAwesomeIcons.arrowLeft,
        ),
      ),
      onPressed: () {
        GoRouter.of(context).pop();
      },
    );
  }
}
