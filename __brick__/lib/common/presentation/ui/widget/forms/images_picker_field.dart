import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../imports/imports.dart';

class ImagesPickerField extends StatelessWidget {
  const ImagesPickerField({
    super.key,
    required this.images,
    required this.networkImages,
    required this.onPickImage,
    required this.onEditImage,
    required this.onDeleteImage,
    this.readOnly = false,
    this.enableMultiImagesPicker = true,
    this.title,
  });

  final List<File?> images;
  final List<String> networkImages;
  final void Function(File image) onPickImage;
  final void Function(int index, File image, bool isNetwork) onEditImage;
  final void Function(int index, bool isNetwork) onDeleteImage;
  final bool readOnly;
  final bool enableMultiImagesPicker;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(title!, style: context.s12w500),
          6.verticalSpace,
        ],
        if ((enableMultiImagesPicker ||
            (images.isEmpty && networkImages.isEmpty)))
          if (readOnly && networkImages.isEmpty || !readOnly) ...[
            _ImagePickerWidget(
              image: null,
              onEditImage: (image) => onEditImage(0, image, false),
              onPickImage: onPickImage,
              onDeleteImage: () => onDeleteImage(0, false),
              readOnly: readOnly,
              isNetwork: false,
              enableMultiImagesPicker: enableMultiImagesPicker,
            ),
            12.verticalSpace,
          ],
        for (int i = 0; i < images.length; i++)
          if (images[i] != null) ...[
            _ImagePickerWidget(
              image: images[i],
              onEditImage: (image) => onEditImage(i, image, false),
              onPickImage: onPickImage,
              onDeleteImage: () => onDeleteImage(i, false),
              readOnly: readOnly,
              isNetwork: false,
              enableMultiImagesPicker: enableMultiImagesPicker,
            ),
            12.verticalSpace,
          ],
        for (int i = 0; i < networkImages.length; i++) ...[
          _ImagePickerWidget(
            image: networkImages[i],
            onEditImage: (image) => onEditImage(i, image, true),
            onPickImage: onPickImage,
            onDeleteImage: () => onDeleteImage(i, true),
            readOnly: readOnly,
            isNetwork: true,
            enableMultiImagesPicker: enableMultiImagesPicker,
          ),
          12.verticalSpace,
        ],
      ],
    );
  }
}

class _ImagePickerWidget extends StatelessWidget {
  const _ImagePickerWidget({
    required this.image,
    required this.onEditImage,
    required this.onPickImage,
    required this.onDeleteImage,
    required this.isNetwork,
    required this.enableMultiImagesPicker,
    this.readOnly = false,
  });

  final dynamic image;
  final void Function(File image) onEditImage;
  final void Function(File image) onPickImage;
  final VoidCallback onDeleteImage;
  final bool readOnly;
  final bool isNetwork;
  final bool enableMultiImagesPicker;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: InkWell(
        onTap: readOnly
            ? null
            : () async {
                if (image != null || !enableMultiImagesPicker) {
                  final file = await pickSingleFile(context);
                  if (file != null) {
                    onEditImage(file);
                  }
                } else {
                  final files = await _pickMultiFiles(context);
                  for (final f in files) {
                    onPickImage(f);
                  }
                }
              },
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            if (image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: isNetwork
                    ? CustomNetworkImage(
                        imageUrl: image.toString(),
                      )
                    : Image.file(image, fit: BoxFit.cover),
              )
            else if (readOnly)
              Center(child: Text(AppString.noImage, style: context.s12w500))
            else
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: context.screenWidth),
                  CircleAvatar(
                    backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                    child: Icon(
                      Icons.upload,
                      color: AppColors.primary,
                    ),
                  ),
                  16.verticalSpace,
                  Text(AppString.uploadImageHere, style: context.s12w500),
                  8.verticalSpace,
                  Text(
                    'JPEG, PNG, PDF · Max 5MB',
                    style: context.s11w500.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            if (image != null && !readOnly)
              Padding(
                padding: REdgeInsets.all(16),
                child: DeleteButton(
                  onTap: onDeleteImage,
                  isLoading: false,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Future<List<File>> _pickMultiFiles(BuildContext context) async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowMultiple: true,
    allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
  );
  if (result == null) {
    return [];
  }

  final files = <File>[];
  for (final f in result.files) {
    final file = File(f.path!);
    if (validateFile(file)) {
      final confirm = await confirmPickedFile(context, file);
      if (confirm) {
        files.add(file);
      }
    }
  }
  return files;
}

Future<ImageSource?> _showImageSourcePicker(
  BuildContext context, {
  bool gallery = false,
}) {
  return showModalBottomSheet<ImageSource>(
    useSafeArea: true,
    context: context,
    backgroundColor: AppColors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (context) {
      return Padding(
        padding: REdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppString.selectSource, style: context.s16w500),
            16.verticalSpace,
            _SourceTile(
              icon: Icons.camera,
              title: AppString.camera,
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            12.verticalSpace,
            _SourceTile(
              icon: gallery ? Icons.browse_gallery : Icons.folder,
              title: gallery ? AppString.gallery : AppString.files,
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      );
    },
  );
}

class _SourceTile extends StatelessWidget {
  const _SourceTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            12.horizontalSpace,
            Text(title, style: context.s14w400),
          ],
        ),
      ),
    );
  }
}

bool validateFile(File file) {
  const maxSize = 5 * 1024 * 1024;
  if (file.lengthSync() > maxSize) {
    BotToast.showText(
      text: AppString.fileTooLarge,
      contentColor: AppColors.warning,
    );
    return false;
  }

  final ext = file.path.split('.').last.toLowerCase();
  if (!['jpg', 'jpeg', 'png', 'pdf'].contains(ext)) {
    BotToast.showText(
      text: AppString.invalidFileType,
      contentColor: AppColors.warning,
    );
    return false;
  }
  return true;
}

Future<bool> confirmPickedFile(BuildContext context, File file) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              AppString.confirmUpload,
              style: context.s16w500,
            ),
            content: Text(
              "${AppString.areYouSureYouWantToUploadThisFile}\n\n${file.path.split('/').last}",
              style: context.s14w400, // 17.sp
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  AppString.cancel,
                  style: context.s14w500.copyWith(
                    color: AppColors.primary,
                  ), // 13.sp w700
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  AppString.confirm,
                  style: context.s14w500.copyWith(
                    color: AppColors.primary,
                  ), // 13.sp w700
                ),
              ),
            ],
          );
        },
      ) ??
      false;
}

Future<File?> pickSingleFile(
  BuildContext context, {
  bool gallery = false,
}) async {
  final source = await _showImageSourcePicker(context, gallery: gallery);
  if (source == null) {
    return null;
  }

  if (source == ImageSource.camera || gallery) {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return null;
    }
    final file = File(image.path);
    if (source == ImageSource.camera) {
      return file;
    }
    if (validateFile(file)) {
      final confirm = await confirmPickedFile(context, file);
      if (confirm) {
        return file;
      }
    }
  } else {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );
    if (result == null) {
      return null;
    }
    final file = File(result.files.single.path!);
    if (validateFile(file)) {
      final confirm = await confirmPickedFile(context, file);
      if (confirm) {
        return file;
      }
    }
  }
  return null;
}
