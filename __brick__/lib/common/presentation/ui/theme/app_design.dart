import '../../../imports/imports.dart';

abstract final class AppDesign {
  const AppDesign._();
  static const Size designSize = Size(390, 844);

  static const double verticalPadding = 16;
  static const double horizontalPadding = 16;
  static EdgeInsets inputContentPadding =
      REdgeInsets.symmetric(vertical: 8, horizontal: 20);
  static BorderRadius radius = BorderRadius.all(Radius.circular(12.r));
  static BorderRadius radiusLarge = BorderRadius.all(Radius.circular(20.r));
    static EdgeInsets horizentalEdgeInsets =
      REdgeInsets.symmetric(horizontal: horizontalPadding);
  static EdgeInsets verticalEdgeInsets =
      REdgeInsets.symmetric(vertical: verticalPadding);
  static EdgeInsets allEdgeInsets = REdgeInsets.symmetric(
    horizontal: horizontalPadding,
    vertical: verticalPadding,
  );


  static double inputHeight = 48.h;
  static double appBarHeight = 56.h;
  static double buttonHeight = 48.h;
  static double avatar = 40.r;
  static double bottomNavHeight = 64.h;

  static double icon = 24.sp;
}
