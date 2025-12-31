import '../../../../../network/exception/failure.dart';

enum ResultStatus {
  init,
  loading,
  loaded,
  error,
}

class Result<T> {
  final ResultStatus status;
  final T? data;
  final Failure? failure;

  const Result._({
    required this.status,
    this.data,
    this.failure,
  });

  /// States
  const Result.init() : this._(status: ResultStatus.init);

  const Result.loading() : this._(status: ResultStatus.loading);

  const Result.loaded({required T data})
      : this._(status: ResultStatus.loaded, data: data);

  const Result.error({required Failure error})
      : this._(
          status: ResultStatus.error,
          failure: error,
        );

  /// Helpers
  bool get isInit => status == ResultStatus.init;
  bool get isLoading => status == ResultStatus.loading;
  bool get isLoaded => status == ResultStatus.loaded;
  bool get isError => status == ResultStatus.error;

  T? get dataOrNull => data;
  String? get errorMessage => failure?.message;
  String? get errorStatusCode => failure?.statusCode;
}
