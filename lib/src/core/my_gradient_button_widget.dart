import 'package:flutter/material.dart';

class MyGradientButtonWidget extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const MyGradientButtonWidget({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 47.0,
    this.gradient = const LinearGradient(colors: [
      Color.fromARGB(255, 214, 99, 183),
      Color.fromARGB(255, 232, 157, 172)
    ]),
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
        boxShadow: const [
          // BoxShadow(
          //     blurStyle: BlurStyle.inner,
          //     blurRadius: 10,
          //     color: Colors.white,
          //     spreadRadius: -10,
          //     offset: Offset(3, 3)),
          BoxShadow(
              blurRadius: 25,
              color: Color.fromARGB(114, 255, 151, 202),
              spreadRadius: 0,
              offset: Offset(0, 12)),
        ],
        border: Border.all(
          color: const Color.fromARGB(255, 230, 121, 185),
          width: 2,
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
        ),
        child: child,
      ),
    );
  }
}
