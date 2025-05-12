import 'package:flutter/material.dart';
import 'package:frontend/providers/routes.dart';
import 'package:frontend/providers/utils.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final double height;

  const BaseAppBar({
    required this.child,
    this.height = 300.0,
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = MediaQuery.of(context).padding;

    return Container(
      margin: EdgeInsets.only(top: padding.top, left: 15.0, right: 15.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Utils.foregroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
  }

  static Widget iconButton({
    required IconData icon,
    void Function()? onTap,
    Color? color,
    double? size,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, size: size ?? 24.0, color: color ?? Utils.textColor),
    );
  }

  static Widget backButton() {
    return iconButton(icon: Icons.arrow_back_ios, onTap: Routes.pop);
  }
}
