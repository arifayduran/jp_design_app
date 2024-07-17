import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jp_design_app/src/core/my_custom_clipper_topcard.dart';
import 'package:jp_design_app/src/core/my_custom_stroke_painter.dart';
import 'package:jp_design_app/src/core/my_gradient_button_widget.dart';

// Image.asset("assets/details/Top Card.png") --> Nicht benutzt, ClipPath und CustomPaint wurde benutzt.

class MyTopCardWidget extends StatelessWidget {
  const MyTopCardWidget(
      {super.key,
      required this.onPressed,
      required this.assetPath,
      required this.title,
      required this.subtitle,
      required this.price,
      required this.reviews});
  final VoidCallback onPressed;
  final String assetPath;
  final String title;
  final String subtitle;
  final double price;
  final double reviews;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      margin: const EdgeInsets.only(right: 21),
      clipBehavior: Clip.none,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            painter: MyCustomStrokePainter(
                strokeWidth: 2, color: const Color.fromARGB(46, 213, 213, 213)),
            child: ClipPath(
              clipper: MyCustomClipperTopcard(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 35.0, sigmaY: 35.0),
                child: SizedBox(
                  height: 240,
                  width: 351,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: "SF Pro",
                                  letterSpacing: -0.5,
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              width: 135,
                              child: Text(subtitle,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.6),
                                      height: 0,
                                      fontWeight: FontWeight.w900)),
                            ),
                            const SizedBox(
                              height: 0,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/Coin-ada-big.svg",
                                  color: Colors.white,
                                  height: 17,
                                ),
                                Text(
                                  " ${price.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: "Inter",
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            MyGradientButtonWidget(
                                width: 94,
                                height: 40,
                                borderStroke: 0.7,
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(colors: [
                                  Color.fromARGB(255, 220, 143, 219),
                                  Color.fromARGB(255, 147, 140, 237)
                                ]),
                                onPressed: onPressed,
                                child: const Text(
                                  "Add to order",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.5,
                                      fontFamily: "Inter",
                                      letterSpacing: -0.9,
                                      fontWeight: FontWeight.w800),
                                )),
                            const SizedBox(
                              height: 3,
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 14,
                                child: Image.asset("assets/icons/star.png")),
                            Text(
                              " ${reviews.toStringAsFixed(1)} ",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            width: 225,
            height: 225,
            child: Image.asset(
              assetPath,
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }
}
