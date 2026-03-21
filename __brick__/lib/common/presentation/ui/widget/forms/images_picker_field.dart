import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

import '/common/presentation/ui/screen/full_image_screen.dart';
import '../../../../imports/imports.dart';

class FileModel {
  final File? file;
  final String? url;
  bool isNetwork;

  FileModel({
    this.file,
    this.url,
  }) : isNetwork = url != null;
}

class ImagesPickerField extends StatelessWidget {
  const ImagesPickerField({
    super.key,
    required this.images,
    required this.onPickImages,
    required this.onEditImage,
    required this.onDeleteImage,
    this.readOnly = false,
    this.withShadow = true,
    this.enableMultiImagesPicker = true,
    this.title,
    this.enableFilesPicker = false,
  });

  final List<FileModel> images;
  final void Function(List<FileModel> images) onPickImages;
  final void Function(
    int index,
    FileModel image,
  ) onEditImage;
  final void Function(
    int index,
  ) onDeleteImage;
  final bool readOnly;
  final bool withShadow;
  final bool enableMultiImagesPicker;
  final String? title;
  final bool enableFilesPicker;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          TitleWidget(
            title: title!,
          ),
        ],
        if (enableMultiImagesPicker || images.isEmpty)
          if (readOnly && images.isEmpty || !readOnly) ...[
            _ImagePickerWidget(
              image: null,
              onEditImage: (image) => onEditImage(0, image),
              onPickImages: onPickImages,
              onDeleteImage: () => onDeleteImage(0),
              readOnly: readOnly,
              canChooseMore: images.isNotEmpty,
              enableMultiImagesPicker: enableMultiImagesPicker,
              withShadow: withShadow,
              enableFilesPicker: enableFilesPicker,
            ),
            12.verticalSpace,
          ],
        for (int i = images.length - 1; i >= 0; i--) ...[
          _ImagePickerWidget(
            image: images[i],
            onEditImage: (image) => onEditImage(i, image),
            onPickImages: onPickImages,
            onDeleteImage: () => onDeleteImage(i),
            readOnly: readOnly,
            enableMultiImagesPicker: enableMultiImagesPicker,
            withShadow: withShadow,
            enableFilesPicker: enableFilesPicker,
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
    required this.onPickImages,
    required this.onDeleteImage,
    required this.enableMultiImagesPicker,
    this.readOnly = false,
    required this.withShadow,
    this.canChooseMore = false,
    this.enableFilesPicker = false,
  });

  final FileModel? image;
  final void Function(FileModel image) onEditImage;
  final void Function(List<FileModel> images) onPickImages;
  final VoidCallback onDeleteImage;
  final bool readOnly;
  final bool withShadow;
  final bool enableMultiImagesPicker;
  final bool canChooseMore;
  final bool enableFilesPicker;
  @override
  Widget build(BuildContext context) {
    final file = image?.file;
    final extension = file != null ? p.extension(file.path).toLowerCase() : '';
    final fileName =
        file != null ? p.dirname(file.path).split("/").last + ".pdf" : '';
    final bool isPdf = extension == ".pdf";
    // final height = image != null && !isPdf ? 150.h : AppDesign.inputHeight;
    return CustomCard(
      // height: height,
      margin: AppDesign.horizentalEdgeInsets,
      padding: EdgeInsets.zero,
      // borderRadius: AppDesign.radius.bottomLeft.x.r,
      // withShadow: withShadow,
      child: Row(
        children: [
          if (!readOnly)
            InkWell(
              onTap: () async {
                if (image != null) {
                  File? file;
                  if (enableFilesPicker) {
                    file = await pickSingleFile();
                  } else {
                    file = await pickSingleImage();
                  }
                  if (file != null) {
                    onEditImage(
                      FileModel(file: file),
                    );
                  }
                } else {
                  List<FileModel> files = [];
                  if (enableMultiImagesPicker) {
                    files = (await _pickMultiFiles(context))
                        .map((file) => FileModel(file: file))
                        .toList();
                  } else if (enableFilesPicker) {
                    files = [FileModel(file: await pickSingleFile())];
                  } else {
                    files = [FileModel(file: await pickSingleImage())];
                  }
                  onPickImages(files);
                }
              },
              child: Container(
                height: context.screenHeight,
                width: 91.w,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: "#DBDADE".toColor(),
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r),
                  ),
                ),
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    image != null ? AppString.editImage : AppString.chooseFile,
                    style: context.labelSmall.copyWith(
                      color: AppColors.grey.withValues(alpha: 0.9),
                    ),
                  ),
                ),
              ),
            ),
          Expanded(
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                InkWell(
                  onTap: image == null
                      ? null
                      : () {
                          // Navigate to the fullscreen view
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullImageScreen(
                                images: image == null ? [] : [image!],
                                initialIndex: 0,
                              ),
                            ),
                          );
                        },
                  child: Container(
                    width: context.screenWidth,
                    decoration: BoxDecoration(
                      // color: AppColors.surface.withOpacity( 0.1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        bottomLeft: Radius.circular(12.r),
                        topRight: readOnly
                            ? Radius.circular(12.r)
                            : const Radius.circular(0),
                        bottomRight: readOnly
                            ? Radius.circular(12.r)
                            : const Radius.circular(0),
                      ),
                    ),
                    child: image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.r),
                              bottomLeft: Radius.circular(12.r),
                            ),
                            child: image!.isNetwork
                                ? CustomNetworkImage(
                                    imageUrl: image!.url!,
                                  )
                                : Builder(
                                    builder: (context) {
                                      if (isPdf) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  TablerIcons.file_type_pdf,
                                                  size: 24.sp,
                                                  color: Colors.red,
                                                ),
                                                8.horizontalSpace,
                                                Expanded(
                                                  child: Text(
                                                    fileName,
                                                    style: context.labelSmall,
                                                    textAlign: TextAlign.end,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                  ),
                                                ),
                                                8.horizontalSpace,
                                              ],
                                            ),
                                          ],
                                        );
                                      }
                                      return Image.file(
                                        file!,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                          )
                        : Row(
                            children: [
                              14.horizontalSpace,
                              Text(
                                canChooseMore == true
                                    ? AppString.chooseMorePictures
                                    : AppString.thereAreNoFilesSelected,
                                style: context.hintText,
                              ),
                            ],
                          ),
                  ),
                ),
                if (image != null && !readOnly)
                  Padding(
                    padding: REdgeInsets.all(8.0),
                    child: DeleteButton(
                      onTap: onDeleteImage,
                      isLoading: false,
                    ),
                  ),
              ],
            ),
          ),
        ],
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
      files.add(file);
    }
  }
  return files;
}

bool validateFile(File file) {
  // const maxSize = 5 * 1024 * 1024;
  // if (file.lengthSync() > maxSize) {
  //   BotToast.showText(
  //     text: AppString.fileTooLarge,
  //     contentColor: AppColors.warning,
  //   );
  //   return false;
  // }

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

Future<File?> pickSingleImage() async {
  if (_isSingleImagePickerActive) {
    return null;
  }
  _isSingleImagePickerActive = true;

  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    printO(image.path);
    final file = File(image.path);

    if (validateFile(file)) {
      return file;
    }
  } on PlatformException catch (e) {
    if (e.code == 'already_active') {
      return null;
    }
    rethrow;
  } finally {
    _isSingleImagePickerActive = false;
  }
  return null;
}

bool _isSingleImagePickerActive = false;

Future<File?> pickSingleFile() async {
  if (_isSingleFilePickerActive) {
    return null;
  }
  _isSingleFilePickerActive = true;

  try {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return null;
    }
    final file = File(result.files.single.path!);
    return file;
  } on PlatformException catch (e) {
    if (e.code == 'already_active') {
      return null;
    }
    rethrow;
  } finally {
    _isSingleFilePickerActive = false;
  }
}

bool _isSingleFilePickerActive = false;
