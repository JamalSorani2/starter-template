// ignore_for_file: avoid_redundant_argument_values

import 'dart:async';

import '../common/services/check_verion_service.dart';
import '/common/presentaion/state/provider/infinity_scroll_provider.dart';
import '/common/presentaion/ui/widget/internet_banner.dart';
import '/common/services/storage_service/internet_status_service.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
import '../common/imports/imports.dart';
import '../common/presentaion/state/bloc/app_manager_bloc.dart';
import '../common/presentaion/state/provider/theme_provider.dart';
import '../common/router/router_config.dart';
import '../common/services/language_service.dart';
import '../common/services/system_ui_service.dart';
import 'auth/domain/repository/auth_repository.dart';
import 'auth/presentation/state/provider/counter_provider.dart';
import 'onBaording/presentation/state/page_index_provider.dart';
import 'root/presentation/state/provider/nav_bar_provider.dart';

late GlobalKey<NavigatorState> navigatorKey;
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

const String _enableRequestInspectStr =
    String.fromEnvironment('ENABLE_REQUEST_INSPECT');
const bool enableRequestInspect = _enableRequestInspectStr == 'true';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final BRouterConfig router;
  late final AppManagerBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = AppManagerBloc(
      doBeforeOpen: _doBeforeOpen,
      context: context,
      authRepository: getIt<AuthRepository>(),
    )..add(AppManagerStarted());

    if (!getIt.isRegistered<AppManagerBloc>()) {
      getIt.registerSingleton<AppManagerBloc>(_bloc);
    }
    router = BRouterConfig(appManagerBloc: _bloc);
    navigatorKey = router.router.routerDelegate.navigatorKey;
    WidgetsFlutterBinding.ensureInitialized();
    InternetStatusService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: ScreenUtilInit(
        designSize: AppDesign.designSize,
        fontSizeResolver: (fontSize, instance) {
          final baseWidth = AppDesign.designSize.width;
          final scaleFactor = instance.screenWidth / baseWidth;
          return fontSize * scaleFactor.clamp(0.85, 1.2);
        },
        builder: (context, child) {
          return MultiProvider(
            providers: [
              BlocProvider.value(value: _bloc),
              ChangeNotifierProvider(
                create: (context) => getIt<NavBarProvider>(),
              ),
              ChangeNotifierProvider(
                create: (context) => getIt<PageIndexProvider>(),
              ),
              ChangeNotifierProvider(
                create: (context) => getIt<CountdownProvider>(),
              ),
              ChangeNotifierProvider(
                create: (context) => getIt<InfinityScrollProvider>(),
              ),
              ChangeNotifierProvider(
                create: (context) => getIt<ThemeProvider>(),
              ),
            ],
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return MaterialApp.router(
                  scaffoldMessengerKey: rootScaffoldMessengerKey,
                  debugShowCheckedModeBanner: false,
                  routerConfig: router.router,
                  theme: AppTheme.theme(context.isEnglish, true),
                  darkTheme: AppTheme.theme(context.isEnglish, false),
                  themeMode: themeProvider.themeMode,
                  builder: (context, child) {
                    SystemUiService.setForTheme(Theme.of(context));
                    LanguageService.init(context);
                    child = BotToastInit()(context, child);
                    // flutter build apk --release --dart-define=ENABLE_REQUEST_INSPECT=true
                    child = RequestInspect(
                      enabled: enableRequestInspect,
                      child: child,
                    );
                    child = DevicePreview.appBuilder(context, child);
                    child = InternetBanner(child: child);
                    return child;
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  FutureOr<void> _doBeforeOpen() async {
    final Completer<void> completer = Completer();
    try {
      await CheckVersionService.checkForUpdates();
      if (!completer.isCompleted) {
        completer.complete();
      }
    } catch (e) {
      completer.complete();
    }
    return completer.future;
  }
}
