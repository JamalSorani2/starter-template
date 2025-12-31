import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../imports/imports.dart';

enum LoadingType {
  // Basic
  rotatingPlain,
  doubleBounce,
  wave,
  wanderingCubes,
  fadingFour,
  fadingCube,

  pulse,
  chasingDots,
  threeBounce,
  circle,
  cubeGrid,
  fadingCircle,

  rotatingCircle,
  foldingCube,
  pumpingHeart,
  hourGlass,
  pouringHourGlass,
  pouringHourGlassRefined,

  fadingGrid,
  ring,
  ripple,
  spinningCircle,
  spinningLines,
  squareCircle,

  dualRing,
  pianoWave,
  dancingSquare,
  threeInOut,
  waveSpinner,
  pulsingGrid,
}

class LoadingProgress extends StatelessWidget {
  const LoadingProgress({
    super.key,
    this.color,
    this.size,
    this.type = LoadingType.fadingCircle,
  });

  final Color? color;
  final double? size;
  final LoadingType type;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _getAnimation(type),
    );
  }

  Widget _getAnimation(LoadingType type) {
    final c = color ?? AppColors.primary;
    final s = size ?? 50.0.r;

    switch (type) {
      case LoadingType.rotatingPlain:
        return SpinKitRotatingPlain(color: c, size: s);

      case LoadingType.doubleBounce:
        return SpinKitDoubleBounce(color: c, size: s);

      case LoadingType.wave:
        return SpinKitWave(color: c, size: s);

      case LoadingType.wanderingCubes:
        return SpinKitWanderingCubes(color: c, size: s);

      case LoadingType.fadingFour:
        return SpinKitFadingFour(color: c, size: s);

      case LoadingType.fadingCube:
        return SpinKitFadingCube(color: c, size: s);

      case LoadingType.pulse:
        return SpinKitPulse(color: c, size: s);

      case LoadingType.chasingDots:
        return SpinKitChasingDots(color: c, size: s);

      case LoadingType.threeBounce:
        return SpinKitThreeBounce(color: c, size: s);

      case LoadingType.circle:
        return SpinKitCircle(color: c, size: s);

      case LoadingType.cubeGrid:
        return SpinKitCubeGrid(color: c, size: s);

      case LoadingType.fadingCircle:
        return SpinKitFadingCircle(color: c, size: s);

      case LoadingType.rotatingCircle:
        return SpinKitRotatingCircle(color: c, size: s);

      case LoadingType.foldingCube:
        return SpinKitFoldingCube(color: c, size: s);

      case LoadingType.pumpingHeart:
        return SpinKitPumpingHeart(color: c, size: s);

      case LoadingType.hourGlass:
        return SpinKitHourGlass(color: c, size: s);

      case LoadingType.pouringHourGlass:
        return SpinKitPouringHourGlass(color: c, size: s);

      case LoadingType.pouringHourGlassRefined:
        return SpinKitPouringHourGlassRefined(color: c, size: s);

      case LoadingType.fadingGrid:
        return SpinKitFadingGrid(color: c, size: s);

      case LoadingType.ring:
        return SpinKitRing(color: c, size: s);

      case LoadingType.ripple:
        return SpinKitRipple(color: c, size: s);

      case LoadingType.spinningCircle:
        return SpinKitSpinningCircle(color: c, size: s);

      case LoadingType.spinningLines:
        return SpinKitSpinningLines(color: c, size: s);

      case LoadingType.squareCircle:
        return SpinKitSquareCircle(color: c, size: s);

      case LoadingType.dualRing:
        return SpinKitDualRing(color: c, size: s);

      case LoadingType.pianoWave:
        return SpinKitPianoWave(color: c, size: s);

      case LoadingType.dancingSquare:
        return SpinKitDancingSquare(color: c, size: s);

      case LoadingType.threeInOut:
        return SpinKitThreeInOut(color: c, size: s);

      case LoadingType.waveSpinner:
        return SpinKitWaveSpinner(color: c, size: s);

      case LoadingType.pulsingGrid:
        return SpinKitPulsingGrid(color: c, size: s);
    }
  }
}
