import 'package:app_name/app/home/presentation/state/home/home_bloc.dart';

import '../../../imports/imports.dart';

void showImageDialog(
  BuildContext context, {
  required List<FileModel> images,
  required int initialIndex,
}) {
  showDialog(
    context: context,
    useSafeArea: false,
    builder: (context) => FullImageScreen(
      images: images,
      initialIndex: initialIndex,
    ),
  );
}

class FullImageScreen extends StatefulWidget {
  const FullImageScreen({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  final List<FileModel> images;
  final int initialIndex;

  @override
  State<FullImageScreen> createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _goToPrevious() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNext() {
    if (_currentIndex < widget.images.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold<HomeBloc, HomeState, void>(
      isRoot: false,
      title: widget.images.length < 2
          ? AppString.showImage
          : '${_currentIndex + 1} / ${widget.images.length}',
      actions: [
        IconButton(
          icon: const Icon(TablerIcons.x),
          onPressed: () => Navigator.pop(context),
        ),
      ],
      resultParam: ResultParam(
        onRefresh: null,
        bloc: getIt<HomeBloc>(),
        result: null,
        bodyBuilder: (_) {
          return Stack(
            children: [
              // PageView for swipe
              PageView.builder(
                controller: _pageController,
                itemCount: widget.images.length,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  final image = widget.images[index];
                  return Center(
                    child: Hero(
                      tag: 'gallery_$index',
                      child: Padding(
                        padding: AppDesign.allEdgeInsets,
                        child: InteractiveViewer(
                          minScale: 1.0,
                          maxScale: 4.0,
                          clipBehavior: Clip.none,
                          child: image.isNetwork
                              ? CustomNetworkImage(
                                  imageUrl: image.url!,
                                  fit: BoxFit.contain,
                                )
                              : Image.file(
                                  image.file!,
                                  fit: BoxFit.contain,
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Transparent tap areas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left tap: previous
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: _goToPrevious,
                    ),
                  ),
                  // Right tap: next
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: _goToNext,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
