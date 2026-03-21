import '../../../../imports/imports.dart';

class UserImage extends StatefulWidget {
  const UserImage({
    super.key,
    this.initialImage,
    this.height,
    this.width,
    required this.onFileChanged,
    this.readOnly = false,
    this.borderRadius,
    this.borderGradeint,
    this.borderWidth,
    this.wihtShadow = true,
    required this.file,
    this.allowDelete = false,
  });

  final double? height;
  final double? width;
  final String? initialImage;
  final void Function(File? file) onFileChanged;
  final bool readOnly;
  final double? borderRadius;
  final Gradient? borderGradeint;
  final double? borderWidth;
  final bool wihtShadow;
  final File? file;
  final bool allowDelete;
  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  Future<void> _pickImage() async {
    final file = await pickSingleImage();
    if (file == null) {
      return;
    }
    widget.onFileChanged(file);
  }

  @override
  Widget build(BuildContext context) {
    final Widget? networkImage = widget.initialImage != null
        ? CustomNetworkImage(
            imageUrl: widget.initialImage!,
            doubleRadius: widget.borderRadius ?? 12.r,
          )
        : null;

    final Widget? fileImage = widget.file != null
        ? Image.file(
            widget.file!,
            fit: BoxFit.cover,
          )
        : null;

    Widget? image = fileImage ?? networkImage;
    if (image != null) {
      image = ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.r),
        child: image,
      );
    }
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GestureDetector(
          onTap: widget.readOnly
              ? null
              : () async {
                  await _pickImage();
                },
          child: CustomCard(
            // height: widget.height,
            // width: widget.width,
            // borderRadius: widget.borderRadius ?? 12.r,
            // withShadow: widget.wihtShadow,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            // borderGradeint: widget.borderGradeint,
            // borderWidth: widget.borderWidth,
            child: image ??
                Icon(
                  TablerIcons.user,
                  color: context.isLight ? AppColors.primary : Colors.white,
                  size: widget.height != null ? widget.height! * 0.6 : null,
                ),
          ),
        ),
        if (!widget.readOnly && widget.allowDelete)
          Positioned(
            bottom: 6.h,
            right: 0,
            child: GestureDetector(
              onTap: () {
                widget.onFileChanged(null);
              },
              child: CustomCard(
                margin: EdgeInsets.zero,
                padding: REdgeInsets.all(8),
                // borderRadius: 40.r,
                child: Icon(
                  TablerIcons.trash,
                  size: 16.sp,
                  color: AppColors.danger,
                ),
              ),
            ),
          )
        else if (!widget.readOnly)
          Positioned(
            bottom: 6.h,
            right: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: CustomCard(
                margin: EdgeInsets.zero,
                padding: REdgeInsets.all(8),
                // borderRadius: 40.r,
                child: Icon(
                  TablerIcons.edit,
                  size: 16.sp,
                  color: context.isLight ? AppColors.primary : Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
