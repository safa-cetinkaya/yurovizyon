import 'package:flutter/material.dart';
import 'package:frontend/providers/utils.dart';
import 'package:frontend/widgets/alert_widgets.dart';

class BaseFutureBuilder<T> extends StatelessWidget {
  final Future<T>? future;
  final Widget Function(AsyncSnapshot<T> snapshot) childFunction;

  const BaseFutureBuilder(
      {required this.childFunction, this.future, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => AlertWidgets.showError(error: snapshot.error));
        }

        if (future != null &&
            (!snapshot.hasData ||
                snapshot.data == null ||
                snapshot.connectionState == ConnectionState.waiting)) {
          return Center(
              child: CircularProgressIndicator(color: Utils.textColor));
        }

        return childFunction(snapshot);
      },
    );
  }
}
