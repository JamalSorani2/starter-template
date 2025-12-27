import '../../../../../common/imports/imports.dart';
import '../../state/provider/nav_bar_provider.dart';
import '../widget/root_navbar.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: context.read<NavBarProvider>().pageController,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const RootNavbar(),
    );
  }
}
