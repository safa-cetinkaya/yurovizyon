import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/providers/routes.dart';
import 'package:frontend/screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.route,
      navigatorKey: Routes.navigatorKey,
      // routes: Routes.routes,
      onGenerateRoute: Routes.generateRoute));
}
