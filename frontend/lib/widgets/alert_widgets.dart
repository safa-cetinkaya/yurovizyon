import 'package:flutter/material.dart';
import 'package:frontend/providers/routes.dart';
import 'package:frontend/providers/utils.dart';

class AlertWidgets {
  static void showSnackbar(String text,
      {Color backgroundColor = Colors.grey, int sec = 5}) {
    final SnackBar snackBar = SnackBar(
      backgroundColor: backgroundColor,
      duration: Duration(seconds: sec),
      content: Text(text),
    );

    ScaffoldMessenger.of(Routes.navigatorKey.currentContext!).clearSnackBars();
    ScaffoldMessenger.of(Routes.navigatorKey.currentContext!)
        .showSnackBar(snackBar);
  }

  static void showError({Object? error}) {
    return showSnackbar((error ?? '').toString(),
        backgroundColor: Utils.errorColor);
  }

  static void showSuccess({Object? text}) =>
      showSnackbar((text ?? '').toString(),
          backgroundColor: Utils.successColor);
}
