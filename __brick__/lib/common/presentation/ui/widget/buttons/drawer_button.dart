import '../../../../imports/imports.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Scaffold.of(context).openEndDrawer();
      },
      icon: const Icon(
        FontAwesomeIcons.list,
      ),
    );
  }
}
