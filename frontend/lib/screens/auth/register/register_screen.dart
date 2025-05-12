import 'package:flutter/material.dart';
import 'package:frontend/providers/routes.dart';
import 'package:frontend/providers/storage.dart';
import 'package:frontend/providers/utils.dart';
import 'package:frontend/screens/auth/login/login_screen.dart';
import 'package:frontend/screens/dashboard/dashboard_screen.dart';
import 'package:frontend/services/api/auth_api.dart';
import 'package:frontend/services/api/base_api.dart';
import 'package:frontend/widgets/alert_widgets.dart';
import 'package:frontend/widgets/base/base_scaffold.dart';
import 'package:frontend/widgets/input_widgets.dart';

part 'register_view.dart';

class RegisterScreen extends StatefulWidget {
  static const String route = "/register";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String username = '', password = '', confirmPassword = '';
  bool loading = false;
  final FocusNode focusNode = FocusNode();

  Future<void> register() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      AlertWidgets.showError(error: "Fill in the necessary blanks.");
      return;
    }
    if (password != confirmPassword) {
      AlertWidgets.showError(error: "Passwords do not match.");
      return;
    }

    setState(() => loading = true);
    try {
      BaseAPI.setBaseServer();
      Storage.user = await AuthAPI.register(username, password);
      await Storage.prefs.setString("session-id", BaseAPI.sessionId!);

      Routes.popAll();
      Routes.replace(path: DashboardScreen.route);
      AlertWidgets.showSnackbar("Signed up!",
          backgroundColor: Utils.successColor);
    } catch (_) {}
    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _build(context);
}
