import 'package:exam_app/config/colors.dart';
import 'package:exam_app/services/navigator_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: whiteColor,
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      navigatorKey: NavigatorKey.navigatorKey,
    );
  }
}
