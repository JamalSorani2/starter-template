import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/presentation/ui/widget/state/result_builder/result.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<GetHomeEvent>(_getHome);
  }

  /// Handles the [GetHomeEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _getHome(GetHomeEvent event, Emitter emit) async {
    emit(state.copyWith(getHomeState: const Result.loading()));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(getHomeState: const Result.loaded(data: unit)));
  }
}
