part of 'home_bloc.dart';

class HomeState {
  Result<Unit> getHomeState;

  HomeState({
    this.getHomeState = const Result.init(),
  });

  HomeState copyWith({
    Result<Unit>? getHomeState,
  }) {
    return HomeState(
      getHomeState: getHomeState ?? this.getHomeState,
    );
  }
}
