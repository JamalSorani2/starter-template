import 'package:crop_your_image/crop_your_image.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../app/home/presentation/state/home/home_bloc.dart';
import '../../../imports/imports.dart';

class CropImagePage extends StatefulWidget {
  const CropImagePage({super.key, required this.file});
  final File file;

  @override
  State<CropImagePage> createState() => _CropImagePageState();
}

class _CropImagePageState extends State<CropImagePage> {
  final _controller = CropController();
  bool _closed = false;

  @override
  Widget build(BuildContext context) {
    return MyScaffold<HomeBloc, HomeState, void>(
      isRoot: false,
      title: AppString.editImage,
      actions: [
        IconButton(
          icon: const Icon(TablerIcons.check),
          onPressed: _closed
              ? null
              : () {
                  _controller.cropCircle();
                  _closed = true;
                },
        ),
      ],
      resultParam: ResultParam(
        onRefresh: () async {},
        bloc: getIt<HomeBloc>(),
        result: null,
        bodyBuilder: (data) {
          return Crop(
            image: widget.file.readAsBytesSync(),
            controller: _controller,
            withCircleUi: true,
            baseColor: Colors.black,
            progressIndicator: const LoadingProgress(),
            overlayBuilder: (context, rect) =>
                CustomPaint(painter: GridBackgroundPainter()),
            onCropped: onCropped,
          );
        },
      ),
    );
  }

  void onCropped(CropResult result) async {
    if (result is CropSuccess) {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/avatar.png');
      await file.writeAsBytes(result.croppedImage);
      if (context.mounted && context.canPop()) {
        Navigator.pop(context, file);
      }
    } else if (result is CropFailure) {
      showGlobalSnackbar(message: result.cause.toString(), isError: true);
    }
  }
}

class GridBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridSize = 36.0.sp;
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1;

    // Vertical lines
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Horizontal lines
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
