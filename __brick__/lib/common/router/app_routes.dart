import '../../app/auth/presentation/ui/screen/login_screen.dart';
import '../../app/auth/presentation/ui/screen/signup_screen.dart';
import '../../app/dashboard/presentation/ui/screen/dashboard_screen.dart';
import '../../app/onboarding/presentation/ui/screens/onboarding_screen.dart';
import '../../app/root/presentation/ui/screen/root_screen.dart';
import '../imports/imports.dart';
import '../presentation/ui/screen/splash_screen.dart';
import '../presentation/ui/screen/update_available.dart';

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

  // static void _addRouteAfter(GoRoute newRoute, String previousPath) {
  //   //TODO
  //   final index = routes.indexWhere((route) => route.path == previousPath);
  //   if (index != -1) {
  //     final existingRoute = routes.any((route) => route.path == newRoute.path);
  //     if (!existingRoute) {
  //       routes.insert(index + 1, newRoute);
  //     } else {
  //       printR('Route with path "${newRoute.path}" already exists');
  //     }
  //   } else {
  //     printR('Route with path "$previousPath" not found');
  //   }
  // }

  /// Adds routes after all routes matching a pattern
  static void addRouteAfterPattern(GoRoute newRoute, String pattern) {
    final routes = AppRoutes.routes();
    final matchingRoutes = getRoutesByPattern(pattern);

    if (matchingRoutes.isEmpty) {
      printR('No routes found matching pattern $pattern');
    }

    // Check if the new route already exists
    final existingRoute = routes.any((route) => route.path == newRoute.path);
    if (existingRoute) {
      printR('Route with path "${newRoute.path}" already exists');
    }

    // Add the route after the first matching route
    // You might want to modify this logic based on your needs
    final firstMatch = matchingRoutes.first;
    final index = routes.indexWhere((route) => route.path == firstMatch.path);
    if (index != -1) {
      routes.insert(index + 1, newRoute);
    }
  }

  /// Gets all routes that match a specific pattern
  static List<GoRoute> getRoutesByPattern(String pattern) {
    return routes().where((route) {
      return route.path.endsWith(pattern);
    }).toList();
  }
}
