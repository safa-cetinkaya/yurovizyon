import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static late SharedPreferences prefs;
  static User? user;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static bool isDesktop() {
    return MediaQuery.of(Routes.navigatorKey.currentContext!).size.width >= 800;
  }
}
