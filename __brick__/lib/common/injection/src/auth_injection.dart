import 'package:dio/dio.dart';

import '../../../app/auth/data/datasource/auth_remote.dart';
import '../../../app/auth/data/repo_imp/auth_repo_imp.dart';
import '../../../app/auth/domain/repository/auth_repository.dart';
import '../../../app/auth/presentation/state/bloc/auth_bloc.dart';
import '../../../app/auth/presentation/state/provider/counter_provider.dart';
import '../../../app/onboarding/presentation/state/page_index_provider.dart';
import '../../../app/root/presentation/state/provider/nav_bar_provider.dart';
import '../../network/models/reactive_token_storage.dart';
import '../../presentation/state/provider/infinity_scroll_provider.dart';
import '../../presentation/state/provider/theme_provider.dart';
import '../injection.dart';

/// Registers all dependencies for the [Auth] module.
Future<void> authInjection() async {
  getIt.registerSingleton<AuthRemote>(AuthRemote(getIt<Dio>()));

  getIt.registerSingleton<AuthRepository>(
    AuthRepoImp(
      remote: getIt<AuthRemote>(),
      reactiveTokenStorage: getIt<ReactiveTokenStorage>(),
    ),
  );

  getIt.registerSingleton<AuthBloc>(
    AuthBloc(repository: getIt<AuthRepository>()),
  );
  getIt.registerFactory<CountdownProvider>(() => CountdownProvider());
  getIt.registerFactory<PageIndexProvider>(() => PageIndexProvider());
  getIt.registerFactory<InfinityScrollProvider>(() => InfinityScrollProvider());
  getIt.registerSingleton<NavBarProvider>(
    NavBarProvider(),
  );
  getIt.registerSingleton<ThemeProvider>(
    ThemeProvider(),
  );
}
