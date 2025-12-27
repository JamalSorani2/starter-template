import '../../../../../common/imports/imports.dart';

class OnBoardingBackground extends StatelessWidget {
  const OnBoardingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight,
      width: context.screenWidth,
      child: Image.asset(
        '',
        fit: BoxFit.fill,
      ),
    );
  }
}
