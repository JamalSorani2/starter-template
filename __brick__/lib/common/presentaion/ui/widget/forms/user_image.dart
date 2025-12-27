import '../../../../imports/imports.dart';

class EditableCircleAvatar extends StatefulWidget {
  const EditableCircleAvatar({
    super.key,
    this.radius,
    this.initialImage,
    required this.onFileChanged,
  });

  final double? radius;
  final String? initialImage;
  final void Function(File? file) onFileChanged;

  @override
  State<EditableCircleAvatar> createState() => _EditableCircleAvatarState();
}

class _EditableCircleAvatarState extends State<EditableCircleAvatar> {
  File? _image;

  Future<void> _pickImage() async {
    final file = await pickSingleFile(context, gallery: true);
    _image = file;
    widget.onFileChanged(file);
  }

  @override
  Widget build(BuildContext context) {
    final ImageProvider? network =
        widget.initialImage != null ? NetworkImage(widget.initialImage!) : null;
    final file = _image != null ? FileImage(_image!) : null;
    final ImageProvider? image = file ?? network;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: widget.radius,
          backgroundColor: AppColors.surface,
          backgroundImage: image,
          child: _image == null
              ? Icon(FontAwesomeIcons.user, size: widget.radius)
              : null,
        ),
        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              padding: REdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.surface,
                  width: 2.w,
                ),
              ),
              child: const Icon(
                FontAwesomeIcons.penToSquare,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
