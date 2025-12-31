import '../../../../imports/imports.dart';

class InfinityScrollWidget<T> extends StatefulWidget {
  const InfinityScrollWidget({
    super.key,
    required this.refresh,
    required this.totalItemsCount,
    required this.items,
    required this.cardBuilder,
    required this.scrollProvider,
    this.enableRefreshIndicator = true,
  });

  final Future<void> Function() refresh;
  final int totalItemsCount;
  final List<T> items;
  final Widget Function(T item, bool isLastItem) cardBuilder;
  final InfinityScrollProvider scrollProvider;
  final bool enableRefreshIndicator;

  @override
  State<InfinityScrollWidget<T>> createState() =>
      _InfinityScrollWidgetState<T>();
}

class _InfinityScrollWidgetState<T> extends State<InfinityScrollWidget<T>> {
  final ScrollController _scrollController = ScrollController();
  late InfinityScrollProvider provider;

  @override
  void initState() {
    super.initState();
    provider = widget.scrollProvider;
    provider.resetToDefault();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        if (!provider.isLoadingMore &&
            widget.items.length < widget.totalItemsCount &&
            provider.pageNumber * KPageSize < widget.totalItemsCount) {
          provider.setPageNumber(pageNumber: provider.pageNumber + 1);
          widget.refresh();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Consumer<InfinityScrollProvider>(
        builder: (context, scrollProvider, child) {
          final child = widget.items.isEmpty
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: const Center(child: NoDataWidget()),
                      ),
                    );
                  },
                )
              : ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: REdgeInsets.only(bottom: 40),
                  itemCount: widget.items.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= widget.items.length) {
                      if (scrollProvider.isLoadingMore) {
                        return const LoadingProgress();
                      } else {
                        return 10.verticalSpace;
                      }
                    }

                    return widget.cardBuilder(
                      widget.items[index],
                      index == widget.items.length - 1,
                    );
                  },
                );
          if (widget.enableRefreshIndicator) {
            return RefreshIndicator(
              onRefresh: () async {
                scrollProvider.setPageNumber(pageNumber: KPageNumber);
                await widget.refresh();
              },
              child: child,
            );
          }
          return child;
        },
      ),
    );
  }
}
