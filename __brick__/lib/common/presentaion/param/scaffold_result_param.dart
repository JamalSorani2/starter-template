import '../../imports/imports.dart';

class ResultParam<B extends BlocBase<S>, S, M> {
  final Future<void> Function() onRefresh;
  final B bloc;
  final Result<M> Function(S state) result;
  final Widget Function(M data) bodyBuilder;

  ResultParam({
    required this.onRefresh,
    required this.bloc,
    required this.result,
    required this.bodyBuilder,
  });
}
