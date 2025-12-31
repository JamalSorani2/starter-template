import '../imports/imports.dart';

extension Context on BuildContext {
  bool get isEnglish => locale == const Locale("en");

  String get route =>
      GoRouter.of(this).routerDelegate.currentConfiguration.uri.toString();

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  bool get isLTR => isEnglish;

  bool get isSmallDevice {
    return screenHeight <= 650;
  }

  bool get isTab {
    return screenHeight >= 1250;
  }

  void pop() => Navigator.pop(this);

  void unFocus() {
    if (FocusScope.of(this).hasFocus) {
      FocusScope.of(this).unfocus();
    }
  }

  double get paddingTop => MediaQuery.of(this).padding.top;

  double get paddingBottom => MediaQuery.of(this).padding.bottom;
}
