import 'package:flutter/material.dart';

class MyCustomClipperTopcard extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double slopeHeight = size.width * 0.1;
    double radius = 30;

    var path = Path()
      ..moveTo(radius, 0)
      ..lineTo(size.width - radius, 0)
      ..arcToPoint(Offset(size.width, radius),
          radius: Radius.circular(radius), clockwise: true)
      ..lineTo(size.width, size.height - slopeHeight - radius)
      ..arcToPoint(Offset(size.width - radius, size.height - slopeHeight),
          radius: Radius.circular(radius), clockwise: true)
      ..lineTo(radius, size.height)
      ..arcToPoint(Offset(0, size.height - radius),
          radius: Radius.circular(radius), clockwise: true)
      ..lineTo(0, radius)
      ..arcToPoint(Offset(radius, 0),
          radius: Radius.circular(radius), clockwise: true)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(MyCustomClipperTopcard oldClipper) => false;
}
