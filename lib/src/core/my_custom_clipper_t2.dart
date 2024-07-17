import 'package:flutter/material.dart';

class MyCustomClipperT2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    (0, 0);
    path.lineTo(40.0, 0);
    path.lineTo(215.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(MyCustomClipperT2 oldClipper) => false;
}
