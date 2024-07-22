import 'package:flutter/material.dart';

ThemeData myThemeData = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 202, 120, 178),
    brightness: Brightness.dark,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 23,
      letterSpacing: -1,
      fontWeight: FontWeight.w900,
      color: Colors.white,
      height: 1.3,
      fontFamily: "Inter",
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      letterSpacing: -1,
      fontFamily: "Inter",
    ),
    bodyMedium: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      color: Color.fromARGB(255, 167, 167, 167),
      fontFamily: "SF Pro",
    ),
    displaySmall: TextStyle(
      fontFamily: "Inter",
    ),
  ),
);
