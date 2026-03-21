import 'dart:async';
import 'dart:developer';

import '../../../../app/auth/domain/repository/auth_repository.dart';
import '../../../imports/imports.dart';

part 'app_manager_event.dart';
part 'app_manager_state.dart';

class AppManagerBloc extends Bloc<AppManagerEvent, AppManagerState> {
  AppManagerBloc({
    required AuthRepository authRepository,
    required this.context,
    this.doBeforeOpen,
  })  : _authRepository = authRepository,
        super(const AppManagerState(status: Status.initial)) {
    on<AppManagerEvent>(_handler);
  }

  final AuthRepository _authRepository;
  final BuildContext context;

  /// Do some initiation before close splash and open app
  final FutureOr<void> Function()? doBeforeOpen;

  late final StreamSubscription<AuthStatus> _authStateStream;

  FutureOr<void> _handler(
    AppManagerEvent event,
    Emitter<AppManagerState> emit,
  ) async {
    if (event is AppMangerUnExpiredApp) {
      emit(state.copyWith(updateRequired: false, canUpdateLater: false));
    }
    if (event is AppMangerExpiredApp) {
      emit(
        state.copyWith(
          updateRequired: event.updateRequired,
          canUpdateLater: event.canUpdateLater,
          enWhatIsNew: event.enWhatIsNew,
          arWhatIsNew: event.arWhatIsNew,
          newVersion: event.newVersion,
        ),
      );
    }
    if (event is AppManagerStarted) {
      try {
        await doBeforeOpen?.call();
      } catch (e, s) {
        log(e.toString(), stackTrace: s);
      }
      _authStateStream = _authRepository.authStatusStream.listen((event) {
        add(
          AppManageStatusChanged(status: event.status, message: event.message),
        );
      });
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
