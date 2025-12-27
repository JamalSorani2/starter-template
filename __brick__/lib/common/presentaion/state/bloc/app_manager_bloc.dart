import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/auth/domain/repository/auth_repository.dart';

part 'app_manager_event.dart';
part 'app_manager_state.dart';

///This bloc use for redirect in go router
class AppManagerBloc extends Bloc<AppManagerEvent, AppManagerState> {
  final AuthRepository _authRepository;

  AppManagerBloc({
    required AuthRepository authRepository,
    this.doBeforeOpen,
    required this.context,
  })  : _authRepository = authRepository,
        super(const AppManagerState(status: Status.initial)) {
    on<AppManagerEvent>(_handler);
  }

  final BuildContext context;

  /// Do some initiation before close splash and open app
  final FutureOr<void> Function()? doBeforeOpen;

  late final StreamSubscription<AuthStatus> _authStateStream;

  FutureOr<void> _handler(
    AppManagerEvent event,
    Emitter<AppManagerState> emit,
  ) async {
    if (event is AppMangerUnExpiredApp) {
      emit(state.copyWith(expired: false, checkedUpdate: true));
    }
    if (event is AppMangerExpiredApp) {
      emit(
        state.copyWith(
          expired: true,
          isSupported: event.isSupported,
          checkedUpdate: true,
        ),
      );
    }
    if (event is AppManagerStarted) {
      try {
        await doBeforeOpen?.call();
      } catch (e, s) {
        log(e.toString(), stackTrace: s);
      }

      _authStateStream = _authRepository.authStatusStream.listen(
        (event) {
          add(
            AppManageStatusChanged(
              status: event.status,
              message: event.message,
            ),
          );
        },
      );
    } else if (event is AppManageStatusChanged) {
      emit(state.copyWith(status: event.status, message: event.message));
    } else if (event is AppManagerLoggedOut) {
      BotToast.showLoading();
      try {
        _authRepository.logout();
      } catch (e) {
        debugPrint(e.toString());
      }
      BotToast.closeAllLoading();
    }
  }

  @override
  Future<void> close() {
    _authStateStream.cancel();
    return super.close();
  }
}
