import '../../common/imports/imports.dart';

// ignore: must_be_immutable
class ResultBuilder<T> extends StatelessWidget {
  ResultBuilder({
    super.key,
    required this.result,
    required this.success,
    this.loading,
    this.init,
    this.onError,
  });

  final Result<T> result;

  final Widget Function(T data) success;
  final Widget Function()? loading;
  final Widget Function()? init;
  final Future<void> Function()? onError;

  @override
  Widget build(BuildContext context) {
    switch (result.status) {
      case ResultStatus.init:
        return init?.call() ??
            RefreshIndicator(
              onRefresh: onError ?? () async {},
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            );

      case ResultStatus.loading:
        return loading?.call() ?? const LoadingProgress();

      case ResultStatus.loaded:
        return success(result.data as T);

      case ResultStatus.error:
        return onError != null
            ? FailureWidget(
                onRetry: onError!,
                message: result.errorMessage,
              )
            : const SizedBox.shrink();
    }
  }
}
