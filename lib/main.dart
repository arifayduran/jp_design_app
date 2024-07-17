import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/services.dart';
import 'package:jp_design_app/src/config/my_theme_data.dart';
import 'package:jp_design_app/src/core/start_screen.dart';
import 'package:scaled_app/scaled_app.dart';

void main() async {
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runAppScaled(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myThemeData,
      home: const StartScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
