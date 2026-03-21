import 'package:cached_network_image/cached_network_image.dart';

import '../../../../app/url.dart';
import '../../../imports/imports.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.doubleRadius,
    this.borderRadius,
  });
  final String? imageUrl;
  final BoxFit fit;
  final double? doubleRadius;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return const FlutterLogo(); //TODO show app logo
    }
    Widget image = CachedNetworkImage(
      imageUrl: AppUrl.baseUrlDevelopment + imageUrl!,
      // filterQuality: FilterQuality.medium,
      placeholder: (context, url) => Padding(
        padding: REdgeInsets.all(8.0),
        child: const LoadingProgress(),
      ),
      errorWidget: (context, url, error) => const FlutterLogo(),
      fit: fit,
    );

    if (borderRadius != null || doubleRadius != null) {
      image = ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(doubleRadius!),
        child: image,
      );
    }

    return image;
  }
}
