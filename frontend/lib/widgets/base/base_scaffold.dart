import 'package:flutter/material.dart';
import 'package:frontend/providers/utils.dart';

class BaseScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final double? safeAreaPadding;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool safeArea;

  const BaseScaffold({
    this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.safeAreaPadding,
    this.floatingActionButton,
    this.drawer,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.safeArea = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Utils.backgroundColor,
      ),
      child: Scaffold(
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          floatingActionButton: floatingActionButton,
          appBar: appBar,
          bottomNavigationBar: bottomNavigationBar,
          drawer: drawer,
          body: safeArea ? SafeArea(child: body ?? Container()) : body),
    );
  }
}
