import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:flutter/services.dart';
import 'package:jp_design_app/src/core/start_screen.dart';
import 'package:scaled_app/scaled_app.dart';

// splacshscreen fln yap?
// inter und sf
// inner shadow hallet

// Container(
//   height: 300,
//   width: MediaQuery.of(context).size.width,
//   decoration: BoxDecoration(
//     image: DecorationImage(
//       image: NetworkImage('your image url'),
//       fit: BoxFit.cover
//     ),
//   ),
//   child: ClipRect(
//     child: BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
//       child: Container(
//         color: Colors.black.withOpacity(0.1),
//       ),
//     ),
//   ),
// );

// debug fehler?
// opacity snack text verschieden

void main() async {
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runAppScaled(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 202, 120, 178),
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white,
            // fontFamily: "SF Pro",
          ),
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700, color: Colors.white,
            // fontStyle: FontStyle.italic,
            // fontFamily: "SF Pro",
          ),
          bodyMedium: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(184, 173, 173, 173),
            // fontFamily: "SF Pro",
          ),
          displaySmall: TextStyle(
              // fontFamily: "SF Pro",
              ),
        ),
      ),
      home: const StartScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
