import 'package:flutter/material.dart';

class MySmallCircleButtonWidget extends StatelessWidget {
  const MySmallCircleButtonWidget({
    super.key,
    this.onTap,
    this.size = 30,
    this.highlightColor = const Color.fromARGB(130, 59, 69, 160),
    this.splashColor = const Color.fromARGB(130, 59, 69, 160),
    this.bgColor = const Color.fromARGB(120, 74, 71, 62),
    this.strokewidth = 0.3,
    required this.child,
  });

  final double size;
  final VoidCallback? onTap;
  final Widget child;
  final Color highlightColor;
  final Color splashColor;
  final Color bgColor;
  final double strokewidth;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      clipBehavior: Clip.antiAlias,
      child: Material(
        borderRadius: BorderRadius.circular(50),
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          highlightColor: highlightColor,
          splashColor: splashColor,
          child: Ink(
            height: size,
            width: size,
            decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: Colors.white.withOpacity(0.7),
                    width: strokewidth,
                    strokeAlign: BorderSide.strokeAlignInside)),
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
