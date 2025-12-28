import 'dart:async';

import 'package:dio_refresh_bot/dio_refresh_bot.dart';

import '../imports/imports.dart';
import '../presentation/state/bloc/app_manager_bloc.dart';

class RefreshStream extends ChangeNotifier {
  RefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class BRouterConfig {
  late final AppManagerBloc appManagerBloc;
  late final GoRouter router;

  BRouterConfig({required this.appManagerBloc}) {
    router = GoRouter(
      initialLocation: '/${RoutesNames.splash}',
      refreshListenable: RefreshStream(appManagerBloc.stream),
      navigatorKey: GlobalKey<NavigatorState>(),
      observers: [BotToastNavigatorObserver()],
      redirect: (context, state) {
        printG("route: ${state.uri.toString()}");
        printC(appManagerBloc.state.status);

        final bool isUpdateAvailable =
            appManagerBloc.state.updateRequired == true;
        final bool isInUpdate = state.uri.toString() == '/update-available';

        if (isInUpdate && isUpdateAvailable) {
          return null;
        }

        final bool onBoaringSeen =
            getIt<SharedPreferences>().getBool(KOnboardingCompleted) ?? false;
        final String currentRoute = state.uri.toString();

        if (!currentRoute.contains(RoutesNames.dashboard)) {
          return "/${RoutesNames.dashboard}";
        }

        if (isUpdateAvailable) {
          return '/update-available';
        } else if (appManagerBloc.state.status == Status.unauthenticated) {
          printG(Status.unauthenticated);
          if (!onBoaringSeen) {
            if (!currentRoute.contains('/onbording')) {
              return '/onbording';
            }
          } else if (!currentRoute.contains('/login')) {
            return '/login';
          }
        } else if (appManagerBloc.state.status == Status.authenticated &&
            !currentRoute.contains('/root')) {
          return '/root';
        }

        return null;
      },
      routes: AppRoutes.routes(),
    );
  }
}
