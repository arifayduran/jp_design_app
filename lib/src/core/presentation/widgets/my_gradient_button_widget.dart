import 'package:flutter/material.dart';

class MyGradientButtonWidget extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final double borderStroke;
  final Widget child;
  final Color borderColor;
  final Color shadowColor;

  const MyGradientButtonWidget({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    required this.borderStroke,
    this.width,
    this.height = 47.0,
    this.borderColor = const Color.fromARGB(255, 230, 121, 185),
    this.gradient = const LinearGradient(colors: [
      Color.fromARGB(255, 240, 105, 204),
      Color.fromARGB(255, 255, 168, 168)
    ]),
    this.shadowColor = const Color.fromARGB(150, 230, 121, 185),
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
        boxShadow: [
          // BoxShadow(
          //     blurStyle: BlurStyle.inner,
          //     blurRadius: 10,
          //     color: Colors.white,
          //     spreadRadius: -10,
          //     offset: Offset(3, 3)),
          BoxShadow(
              blurRadius: 22,
              color: shadowColor,
              spreadRadius: 0,
              offset: const Offset(-1, 9)),
        ],
        border: Border.all(
          color: borderColor,
          width: borderStroke,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          padding: const EdgeInsets.all(0),
        ),
        child: child,
      ),
    );
  }
}
