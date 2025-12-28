import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common/presentation/ui/widget/state/result_builder/result.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../../data/models/login_auth_model.dart';
import '../../../domain/entities/login_auth_param.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;
  AuthBloc({required AuthRepository repository})
      : _repository = repository,
        super(AuthState()) {
    on<LoginAuthEvent>(_loginAuth);
  }

  /// Handles the [LoginAuthEvent].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  Future<void> _loginAuth(LoginAuthEvent event, Emitter emit) async {
    emit(state.copyWith(loginAuthState: const Result.loading()));
    final response =
        await _repository.loginAuth(loginAuthParam: event.loginAuthParam);
    response.fold(
      (l) => emit(state.copyWith(loginAuthState: Result.error(error: l))),
      (r) => emit(state.copyWith(loginAuthState: Result.loaded(data: r))),
    );
  }
}
