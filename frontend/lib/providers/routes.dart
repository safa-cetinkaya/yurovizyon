import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/login/login_screen.dart';
import 'package:frontend/screens/auth/profile_edit/profile_edit_screen.dart';
import 'package:frontend/screens/auth/register/register_screen.dart';
import 'package:frontend/screens/dashboard/dashboard_screen.dart';
import 'package:frontend/screens/preference_edit/preference_edit_screen.dart';
import 'package:frontend/screens/settings/settings_screen.dart';
import 'package:frontend/screens/splash/splash_screen.dart';
import 'package:frontend/screens/users/users_screen.dart';

class Routes {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Map<String, Widget Function(BuildContext)> routes = {
    SplashScreen.route: (context) => const SplashScreen(),
    DashboardScreen.route: (context) => const DashboardScreen(),
    SettingsScreen.route: (context) => const SettingsScreen(),
    LoginScreen.route: (context) => const LoginScreen(),
    RegisterScreen.route: (context) => const RegisterScreen(),
    PreferenceEditScreen.route: (context) => const PreferenceEditScreen(),
    ProfileEditScreen.route: (context) => const ProfileEditScreen(),
    UsersScreen.route: (context) => const UsersScreen(),
  };

  static Route<Widget> generateRoute(RouteSettings settings) {
    late Widget page;

    switch (settings.name) {
      default:
        page =
            Routes.routes[settings.name]!(Routes.navigatorKey.currentContext!);
        break;
    }

    return PageRouteBuilder(
        settings: RouteSettings(name: settings.name),
        pageBuilder: (_, __, ___) => page);
  }

  static Future<dynamic> pushNamed(routePath,
      {dynamic arg, bool replace = false}) {
    if (replace) pop();

    return navigatorKey.currentState!.pushNamed(routePath, arguments: arg);
  }

  static Future<dynamic> replace({required String path, dynamic arg}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(path, arguments: arg);
  }

  static void pop({dynamic data}) {
    navigatorKey.currentState!.pop(data);
  }

  static void popAll({force = false}) {
    while (navigatorKey.currentState!.canPop()) {
      pop();
    }
    if (force) pop();
  }
}
