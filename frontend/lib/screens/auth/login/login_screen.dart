import 'package:flutter/material.dart';
import 'package:frontend/providers/routes.dart';
import 'package:frontend/providers/storage.dart';
import 'package:frontend/providers/utils.dart';
import 'package:frontend/screens/auth/register/register_screen.dart';
import 'package:frontend/screens/dashboard/dashboard_screen.dart';
import 'package:frontend/services/api/auth_api.dart';
import 'package:frontend/services/api/base_api.dart';
import 'package:frontend/widgets/alert_widgets.dart';
import 'package:frontend/widgets/base/base_scaffold.dart';
import 'package:frontend/widgets/input_widgets.dart';

part 'login_view.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "/login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '', password = '';
  bool loading = false;
  final FocusNode focusNode = FocusNode();

  Future<void> login() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (username.isEmpty || password.isEmpty) {
      AlertWidgets.showError(error: "Fill in the necessary blanks.");
      return;
    }

    setState(() => loading = true);
    try {
      BaseAPI.setBaseServer();
      Storage.user = await AuthAPI.login(username, password);
      await Storage.prefs.setString("session-id", BaseAPI.sessionId!);

      Routes.popAll();
      Routes.replace(path: DashboardScreen.route);
      AlertWidgets.showSnackbar("Signed in!",
          backgroundColor: Utils.successColor);
    } catch (e) {
      AlertWidgets.showSnackbar("Didn't work: $e",
          backgroundColor: Utils.errorColor);
    }
    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _build(context);
}
