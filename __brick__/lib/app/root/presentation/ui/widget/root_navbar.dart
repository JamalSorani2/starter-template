import '../../../../../common/imports/imports.dart';
import '../../state/provider/nav_bar_provider.dart';

class RootNavbar extends StatelessWidget {
  const RootNavbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NavBarProvider>(
      builder: (context, pro, _) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          border: Border.all(color: AppColors.primary),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            onTap: (index) => pro.changeSelected(index),
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.grey,
            currentIndex: pro.selectedIndex,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_sharp),
                label: 'المواد',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'المفضلة',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'الإعدادات',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
