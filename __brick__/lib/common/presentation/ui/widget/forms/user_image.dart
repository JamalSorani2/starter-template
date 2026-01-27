import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../imports/imports.dart';
import '../../screen/crop_image_page.dart';

class UserImage extends StatefulWidget {
  const UserImage({
    super.key,
    this.radius,
    this.initialImage,
    required this.onFileChanged,
    this.readOnly = false,
  });

  final double? radius;
  final String? initialImage;
  final void Function(File? file) onFileChanged;
  final bool readOnly;

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File? _image;

  Future<void> _pickImage() async {
    final file = await pickSingleFile(context, gallery: true);
    if (file == null) {
      return;
    }

    await _cropImage(file);
  }

  Future<void> _cropImage(File file) async {
    final cropped = await Navigator.push<File?>(
      context,
      MaterialPageRoute(
        builder: (_) => CropImagePage(file: file),
      ),
    );

    if (cropped != null) {
      setState(() => _image = cropped);
      widget.onFileChanged(cropped);
    }
  }

  Future<File> _downloadNetworkImage(String url) async {
    final response = await NetworkAssetBundle(Uri.parse(url)).load(url);
    final bytes = response.buffer.asUint8List();

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/avatar_network.png');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    final ImageProvider? networkImage =
        widget.initialImage != null ? NetworkImage(widget.initialImage!) : null;

    final ImageProvider? fileImage = _image != null ? FileImage(_image!) : null;

    final ImageProvider? image = fileImage ?? networkImage;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GestureDetector(
          onTap: widget.readOnly
              ? null
              : () async {
                  // If local image exists → crop it
                  if (_image != null) {
                    await _cropImage(_image!);
                  }
                  // If only network image exists → download then crop
                  else if (widget.initialImage != null) {
                    final file =
                        await _downloadNetworkImage(widget.initialImage!);
                    await _cropImage(file);
                    //TODO send to back end new image
                  }
                  // No image yet → open gallery
                  else {
                    await _pickImage();
                  }
                },
          child: CircleAvatar(
            radius: widget.radius,
            backgroundColor:
                image == null ? AppColors.textPrimary : AppColors.surface,
            backgroundImage: image,
            child: image == null
                ? Icon(
                    Icons.person,
                    size: widget.radius != null ? widget.radius! * 1.5 : null,
                  )
                : null,
          ),
        ),

        /// Pen button (Pick new image)
        if (!widget.readOnly)
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                padding: REdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  TablerIcons.pencil,
                  size: 16.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
