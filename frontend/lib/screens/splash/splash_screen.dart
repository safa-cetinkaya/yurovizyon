import 'package:flutter/material.dart';
import 'package:frontend/providers/routes.dart';
import 'package:frontend/providers/storage.dart';
import 'package:frontend/screens/auth/login/login_screen.dart';
import 'package:frontend/screens/dashboard/dashboard_screen.dart';
import 'package:frontend/services/api/auth_api.dart';
import 'package:frontend/widgets/base/base_scaffold.dart';

part 'splash_view.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "/";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loading = false;

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() => loading = true);

    await Storage.init();
    await Future.delayed(const Duration(seconds: 1));

    String? sessionId = Storage.prefs.getString('session-id');
    if (sessionId != null) {
      try {
        Storage.user = await AuthAPI.checkSession(sessionId);

        Routes.replace(path: DashboardScreen.route);
        return;
      } catch (_) {}
    }

    Routes.replace(path: LoginScreen.route);
  }

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) => _build(context);
}
