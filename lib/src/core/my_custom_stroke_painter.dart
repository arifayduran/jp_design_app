import 'package:flutter/material.dart';

class MyCustomStrokePainter extends CustomPainter {
  Color color;
  double strokeWidth;
  MyCustomStrokePainter({required this.color, required this.strokeWidth});
  @override
  void paint(Canvas canvas, Size size) {
    double slopeHeight = size.width * 0.1;
    double radius = 30;
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

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
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
