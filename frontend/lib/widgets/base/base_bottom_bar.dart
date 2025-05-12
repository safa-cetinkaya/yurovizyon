import 'package:flutter/material.dart';
import 'package:frontend/providers/utils.dart';

class BaseBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;

  const BaseBottomNavigationBar({required this.selectedIndex, super.key});

  @override
  State<BaseBottomNavigationBar> createState() =>
      _BaseBottomNavigationBarState();
}

class _BaseBottomNavigationBarState extends State<BaseBottomNavigationBar> {
  final double iconSize = 30;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Utils.backgroundColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: iconSize), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, size: iconSize), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.history, size: iconSize), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.map, size: iconSize), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: iconSize), label: ""),
        ],
        currentIndex: widget.selectedIndex,
        selectedItemColor: Utils.primaryColor,
        unselectedItemColor: Colors.white,
        onTap: (value) async {
          if (widget.selectedIndex == value) return;

          switch (value) {
            case 0:
              break;
            case 1:
              break;
            case 2:
              break;
            case 3:
              break;
            case 4:
              break;
            default:
          }

          setState(() {});
        },
      ),
    );
  }
}
