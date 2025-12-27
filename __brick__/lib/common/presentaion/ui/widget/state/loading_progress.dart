import '../../../../imports/imports.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingProgress extends StatelessWidget {
  const LoadingProgress({super.key, this.color, this.size});
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        color: color ?? AppColors.primary,
        size: size ?? 50.0.r,
      ),
    );
  }
}

/*
Other types of loading animations you can use:

Double bouncing dots
SpinKitDoubleBounce(
  color: color,
  size: size,
),

Rotating circle
SpinKitRotatingCircle(
  color: color,
  size: size,
),

Wave
SpinKitWave(
  color: color,
  size: size,
),

Chasing dots
SpinKitChasingDots(
  color: color,
  size: size,
),

Three bouncing dots
SpinKitThreeBounce(
  color: color,
  size: size,
),

Folding cube
SpinKitFoldingCube(
  color: color,
  size: size,
),

Pulsing grid
SpinKitPulsingGrid(
  color: color,
  size: size,
),
*/
