import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../imports/imports.dart';

enum LoadingType {
  fadingCircle,
  doubleBounce,
  rotatingCircle,
  wave,
  chasingDots,
  threeBounce,
  foldingCube,
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
    final animation = _getAnimation(type);
    return Center(
      child: animation,
    );
  }

  /// Factory method to return the right SpinKit animation
  Widget _getAnimation(LoadingType type) {
    switch (type) {
      case LoadingType.fadingCircle:
        return SpinKitFadingCircle(
          color: color ?? AppColors.primary,
          size: size ?? 50.0.r,
        );
      case LoadingType.doubleBounce:
        return SpinKitDoubleBounce(
          color: color ?? AppColors.primary,
          size: size ?? 50.0.r,
        );
      case LoadingType.rotatingCircle:
        return SpinKitRotatingCircle(
          color: color ?? AppColors.primary,
          size: size ?? 50.0.r,
        );
      case LoadingType.wave:
        return SpinKitWave(
          color: color ?? AppColors.primary,
          size: size ?? 50.0.r,
        );
      case LoadingType.chasingDots:
        return SpinKitChasingDots(
          color: color ?? AppColors.primary,
          size: size ?? 50.0.r,
        );
      case LoadingType.threeBounce:
        return SpinKitThreeBounce(
          color: color ?? AppColors.primary,
          size: size ?? 50.0.r,
        );
      case LoadingType.foldingCube:
        return SpinKitFoldingCube(
          color: color ?? AppColors.primary,
          size: size ?? 50.0.r,
        );
      case LoadingType.pulsingGrid:
        return SpinKitPulsingGrid(
          color: color ?? AppColors.primary,
          size: size ?? 50.0.r,
        );
    }
  }
}
