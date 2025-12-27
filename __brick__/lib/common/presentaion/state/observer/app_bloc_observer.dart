import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../../helper/colored_print.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    printB('📦 [EVENT] ${bloc.runtimeType}: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    printC('🔄 [CHANGE] ${bloc.runtimeType}: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    printY('➡️ [TRANSITION] ${bloc.runtimeType}: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    printR('❌ [ERROR] ${bloc.runtimeType}: $error');
    if (kDebugMode) {
      print(stackTrace);
    }
  }
}
