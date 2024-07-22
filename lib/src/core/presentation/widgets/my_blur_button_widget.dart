import 'dart:ui';

import 'package:flutter/material.dart';

class MyBlurButtonWidget extends StatelessWidget {
  const MyBlurButtonWidget({
    super.key,
    required this.onPressed,
    required this.borderRadius,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.withBorder,
    required this.child,
  });
  final VoidCallback? onPressed;
  final double borderRadius;
  final double width;
  final double height;
  final Color backgroundColor;
  final bool withBorder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 7),
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: withBorder == true
            ? Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
                strokeAlign: BorderSide.strokeAlignInside,
              )
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 30, sigmaY: 0, tileMode: TileMode.clamp),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: backgroundColor,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.all(0),

              // shape: RoundedRectangleBorder(borderRadius: widget.borderRadius),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
