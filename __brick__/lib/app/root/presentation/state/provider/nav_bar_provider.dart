import 'package:flutter/material.dart';

class NavBarProvider extends ChangeNotifier {
  late PageController pageController;
  int selectedIndex = 0;
  NavBarProvider() {
    pageController = PageController();
  }

  void changeSelected(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutExpo,
    );
    selectedIndex = index;
    notifyListeners();
  }
}
