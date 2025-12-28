import '../../../../../imports/imports.dart';

// ignore: must_be_immutable
class ResultBuilder<T> extends StatelessWidget {
  ResultBuilder({
    super.key,
    required this.success,
    this.loading,
    required this.onError,
    this.init,
    required this.result,
  });

  final Result<T> result;
  Widget Function()? loading;
  final Widget Function(T data) success;
  final Future<void> Function()? onError;
  Widget Function()? init;

  @override
  Widget build(BuildContext context) {
    Widget? next;

    loading ??= () => const LoadingProgress();
    init ??= () => const SizedBox();
    result.when(
      init: () => next = RefreshIndicator(
        onRefresh: onError ?? () async {},
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(height: MediaQuery.of(context).size.height),
            ],
          ),
        ),
      ),
      loading: () => next = loading!(),
      loaded: (data) => next = success(data),
      error: (message) => onError != null
          ? {
              next = FailureWidget(
                onRetry: onError!,
                message: message.message,
              ),
            }
          : const SizedBox.shrink(),
    );
    return next ?? const SizedBox();
  }
}
