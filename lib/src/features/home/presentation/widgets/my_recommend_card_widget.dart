import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyRecommendCardWidget extends StatelessWidget {
  const MyRecommendCardWidget(
      {super.key,
      required this.onTap,
      required this.assetPath,
      required this.title,
      required this.subtitle,
      required this.price,
      required this.likedCount});

  final VoidCallback onTap;
  final String assetPath;
  final String title;
  final String subtitle;
  final double price;
  final int likedCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 23),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Material(
          child: InkWell(
            highlightColor: const Color.fromARGB(180, 142, 134, 255),
            splashColor: const Color.fromARGB(180, 148, 88, 207),
            onTap: onTap,
            child: Ink(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 270,
              width: 203,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(46, 213, 213, 213),
                  ),
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(180, 107, 109, 128),
                        Color.fromARGB(180, 142, 134, 255),
                        Color.fromARGB(180, 148, 88, 207),
                      ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 160,
                    width: 160,
                    child: Image.asset(
                      assetPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontFamily: "Inter",
                          height: 0,
                          letterSpacing: -0.5,
                          fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      subtitle,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          overflow: TextOverflow.ellipsis,
                          letterSpacing: -0.3,
                          color: Colors.white.withOpacity(0.4),
                          fontFamily: "Inter",
                          fontSize: 12.8),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/Coin-ada-big.svg",
                        color: Colors.white,
                        height: 15,
                      ),
                      Text(
                        price.toStringAsFixed(2),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontFamily: "SF Pro",
                            fontSize: 13.5),
                      ),
                      const Expanded(child: SizedBox()),
                      Icon(
                        Icons.favorite_outline,
                        size: 17,
                        color: Colors.white.withOpacity(0.4),
                      ),
                      Text(
                        " $likedCount",
                        style: TextStyle(
                            fontFamily: "SF Pro",
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 13.5),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
