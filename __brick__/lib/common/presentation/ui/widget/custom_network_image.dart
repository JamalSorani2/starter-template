import 'package:cached_network_image/cached_network_image.dart';

import '../../../imports/imports.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
  });
  final String imageUrl;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      filterQuality: FilterQuality.medium,
      placeholder: (context, url) => Padding(
        padding: REdgeInsets.all(8.0),
        child: const LoadingProgress(),
      ),
      errorWidget: (context, url, error) => const FlutterLogo(),
      fit: fit,
    );
  }
}
