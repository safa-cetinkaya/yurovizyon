import 'package:flutter/material.dart';

class Utils {
  static const String devServer = 'localhost:8000';
  static const String prodServer = '172.20.10.2:8000';

  static const Color primaryColor = Color.fromARGB(255, 27, 0, 191);
  static const Color errorColor = Colors.red;
  static const Color successColor = Color.fromARGB(255, 0, 86, 3);

  /*
  static Color backgroundColor = Color.fromARGB(255, 197, 106, 168);
  static Color foregroundColor = Color.fromARGB(255, 166, 67, 136);
  static Color listTileColor = Color.fromARGB(255, 119, 66, 131);
  */

  static Color backgroundColor = const Color.fromARGB(255, 9, 17, 126);
  static Color foregroundColor = const Color.fromARGB(255, 15, 52, 122);

  static Color textColor = Colors.white70;
  static Color inactiveColor = const Color.fromARGB(255, 97, 90, 90);

  static Map<int, String> orderMap = {
    12: '1',
    10: '2',
    9: '3',
    8: '4',
    7: '5',
    6: '6',
    5: '7',
    4: '8',
    3: '9',
    2: '10',
    1: '11',
  };
}
