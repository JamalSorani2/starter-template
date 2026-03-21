import '../../app/auth/presentation/ui/screen/login_screen.dart';
import '../../app/auth/presentation/ui/screen/signup_screen.dart';
import '../../app/dashboard/presentation/ui/screen/dashboard_screen.dart';
import '../../app/onboarding/presentation/ui/screens/onboarding_screen.dart';
import '../../app/root/presentation/ui/screen/root_screen.dart';
import '../imports/imports.dart';

class AppRoutes {
  static List<GoRoute> routes() => [
        GoRoute(
          path: "/${RoutesNames.splash}",
          name: RoutesNames.splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: "/${RoutesNames.updateAvailable}",
          name: RoutesNames.updateAvailable,
          builder: (context, state) => const UpdateAvailable(),
        ),
        GoRoute(
          path: "/${RoutesNames.onBoarding}",
          name: RoutesNames.onBoarding,
          builder: (context, state) => const OnBoardingScreen(),
        ),
        GoRoute(
          path: "/${RoutesNames.login}",
          name: RoutesNames.login,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: "/${RoutesNames.signup}",
          name: RoutesNames.signup,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: "/${RoutesNames.root}",
          name: RoutesNames.root,
          builder: (context, state) => const RootScreen(),
        ),
        GoRoute(
          path: "/${RoutesNames.dashboard}",
          name: RoutesNames.dashboard,
          builder: (context, state) => const DashboardScreen(),
        ),
      ];
}

class RoutesNames {
  static const String splash = 'splash';
  static const String updateAvailable = 'update-available';
  static const String onBoarding = 'onbording';
  static const String login = 'login';
  static const String signup = 'signup';
  static const String root = 'root';
  static const String dashboard = 'dashboard';
}
