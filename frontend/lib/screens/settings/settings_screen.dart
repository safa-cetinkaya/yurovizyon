import 'package:flutter/material.dart';
import 'package:frontend/providers/routes.dart';
import 'package:frontend/providers/storage.dart';
import 'package:frontend/providers/utils.dart';
import 'package:frontend/screens/auth/login/login_screen.dart';
import 'package:frontend/screens/auth/profile_edit/profile_edit_screen.dart';
import 'package:frontend/services/api/auth_api.dart';
import 'package:frontend/widgets/alert_widgets.dart';
import 'package:frontend/widgets/base/base_app_bar.dart';
import 'package:frontend/widgets/base/base_scaffold.dart';

part 'settings_view.dart';

class SettingsScreen extends StatefulWidget {
  static const String route = "/settings";

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void localSetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => _build(context);
}
