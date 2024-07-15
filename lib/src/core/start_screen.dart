import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jp_design_app/src/core/my_gradient_button_widget.dart';
import 'package:smooth_corner/smooth_corner.dart';


class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double logicWidth = 393;
    double logicHeight = 852;

    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          color: const Color.fromARGB(255, 45, 42, 34),
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            child: Container(
              width: logicWidth,
              height: logicHeight,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background/bg_startscreen.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 99,
                    left: -30,
                    child: SizedBox(
                      height: 553,
                      width: 553,
                      child: Image.asset(
                        "assets/graphics/chick cupcakes_3D.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 100,
                    width: 393,
                    child: Opacity(
                      opacity: 0.4,
                      child: Image.asset(
                        "assets/details/T2.png",
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    left: 25,
                    right: 25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                        child: SmoothContainer(
                          height: 217,
                          smoothness: 0.6,
                          padding: const EdgeInsets.all(32),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 131, 131, 131),
                              width: 0.1,
                              strokeAlign: BorderSide.strokeAlignOutside),
                          borderRadius: BorderRadius.circular(35),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Feeling Snackish Today?",
                                style:
                                    Theme.of(context).textTheme.displayLarge!,
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                "Explore Angi's most popular snack selection and get instantly happy.",
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              MyGradientButtonWidget(
                                width: 207,
                                onPressed: () {},
                                borderRadius: BorderRadius.circular(10),
                                child: Text(
                                  "Order Now",
                                  style:
                                      Theme.of(context).textTheme.titleLarge!,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
