import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jp_design_app/src/core/my_gradient_button_widget.dart';
import 'package:jp_design_app/src/features/home/domain/item.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:toggle_switch/toggle_switch.dart';

void myBottomSheetWidget(BuildContext context, Item item) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return MyModalBottomSheet(context: context, item: item);
    },
  );
}

class MyModalBottomSheet extends StatefulWidget {
  const MyModalBottomSheet({
    super.key,
    required this.context,
    required this.item,
  });

  final BuildContext context;
  final Item item;

  @override
  State<MyModalBottomSheet> createState() => _MyModalBottomSheetState();
}

class _MyModalBottomSheetState extends State<MyModalBottomSheet> {
  Icon favIcon = Icon(Icons.favorite_border,
      size: 17, color: Colors.white.withOpacity(0.4));
  bool isFavorite = false;
  int favCountNew = 0;
  int selectedSizeIndex = 2;
  double basePrice = 0.0;
  double currentPrice = 0.0;

  int counter = 1;

  void incrementCounter() {
    setState(() {
      counter++;
      updatePrice();
    });
  }

  void decrementCounter() {
    setState(() {
      counter--;
      if (counter <= 1) {
        counter = 1;
      }
      updatePrice();
    });
  }

  void updatePrice() {
    double sizeMultiplier;
    switch (selectedSizeIndex) {
      case 0:
        sizeMultiplier = 0.6;
        break;
      case 1:
        sizeMultiplier = 0.8;
        break;
      case 2:
        sizeMultiplier = 1.0;
        break;
      default:
        sizeMultiplier = 1.0;
    }
    currentPrice = basePrice * sizeMultiplier * counter;
  }

  @override
  void initState() {
    super.initState();
    favCountNew = widget.item.likedCount;
    basePrice = widget.item.price;
    currentPrice = basePrice;
  }

  List<Widget> generateReviewStars(double rating) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      if (rating >= i) {
        stars.add(const Icon(Icons.star_rate, color: Colors.white, size: 16));
      } else if (rating >= i - 0.5) {
        stars.add(const Icon(Icons.star_half, color: Colors.white, size: 16));
      } else {
        stars.add(const Icon(Icons.star_border, color: Colors.white, size: 16));
      }
    }
    return stars;
  }

  List<Widget> getIngredientsIcons(Item item) {
    List<Widget> icons = [];
    if (item.isGluten) {
      icons.add(Padding(
        padding: const EdgeInsets.only(right: 7),
        child:
            Image.asset('assets/icons/gluten_icon.png', width: 20, height: 20),
      ));
    }
    if (item.isSugar) {
      icons.add(Padding(
          padding: const EdgeInsets.only(right: 7),
          child: Image.asset('assets/icons/sugar_icon.png',
              width: 20, height: 20)));
    }
    if (item.isLowFat) {
      icons.add(Padding(
          padding: const EdgeInsets.only(right: 7),
          child: Image.asset('assets/icons/lowfat_icon.png',
              width: 20, height: 20)));
    }
    if (item.isKcal) {
      icons.add(Padding(
          padding: const EdgeInsets.only(right: 7),
          child: Image.asset('assets/icons/kcal_icon.png',
              width: 20, height: 20)));
    }
    return icons;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          clipBehavior: Clip.none,
          height: 754,
          width: 393,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.6,
                  1.0
                ],
                colors: [
                  Color.fromARGB(255, 46, 43, 35),
                  Color.fromARGB(255, 56, 66, 66)
                ]),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: const EdgeInsets.all(16),
        ),
        Positioned(
          top: -133,
          height: 400,
          width: 400,
          child: Image.asset(
            widget.item.assetPath ?? "assets/graphics/noimage.png",
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          top: 18,
          right: 12,
          width: 30,
          height: 30,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            clipBehavior: Clip.antiAlias,
            child: Material(
              borderRadius: BorderRadius.circular(50),
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                highlightColor: const Color.fromARGB(180, 142, 134, 255),
                splashColor: const Color.fromARGB(180, 148, 88, 207),
                child: Ink(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(120, 74, 71, 62),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.7),
                          width: 0.3,
                          strokeAlign: BorderSide.strokeAlignInside)),
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 175,
          left: 25,
          right: 25,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
              child: SmoothContainer(
                height: 340,
                smoothness: 0.6,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                side: const BorderSide(
                    color: Color.fromARGB(75, 193, 170, 218),
                    width: 0.5,
                    strokeAlign: BorderSide.strokeAlignOutside),
                borderRadius: BorderRadius.circular(30),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                              if (isFavorite) {
                                favIcon = const Icon(Icons.favorite,
                                    size: 17, color: Colors.red);
                                favCountNew++;
                              } else {
                                favIcon = Icon(Icons.favorite_border,
                                    size: 17,
                                    color: Colors.white.withOpacity(0.4));
                                favCountNew--;
                              }
                            });
                          },
                          child: favIcon,
                        ),
                        Text(
                          " $favCountNew",
                          style: TextStyle(
                              fontFamily: "SF Pro",
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 13.5),
                        ),
                      ],
                    ),
                    Text(
                      widget.item.title,
                      style: Theme.of(context).textTheme.displayLarge!,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 110,
                      width: double.infinity,
                      child: Text(
                        widget.item.description ?? widget.item.subtitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/Coin-ada-big.svg",
                          color: Colors.white,
                          height: 20,
                        ),
                        Text(
                          widget.item.price.toStringAsFixed(2),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontFamily: "Inter",
                              letterSpacing: 0,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color.fromARGB(110, 201, 182, 221),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 115,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Ingredients",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.4,
                                  color: Color.fromARGB(255, 167, 167, 167),
                                  fontFamily: "Inter",
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: getIngredientsIcons(widget.item),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 115,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Reviews",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.4,
                                  color: Color.fromARGB(255, 167, 167, 167),
                                  fontFamily: "Inter",
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: generateReviewStars(
                                        widget.item.reviews),
                                  ),
                                  Text(
                                    widget.item.reviews.toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.4,
                                      color: Color.fromARGB(255, 167, 167, 167),
                                      fontFamily: "Inter",
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 135,
          left: 25,
          child: ToggleSwitch(
            activeBgColor: [const Color.fromARGB(255, 108, 108, 108)],
            inactiveBgColor: const Color.fromARGB(140, 85, 85, 85),
            activeFgColor: Colors.white,
            inactiveFgColor: Colors.white.withOpacity(0.6),
            initialLabelIndex: selectedSizeIndex,
            fontSize: 11.3,
            dividerMargin: 9,
            radiusStyle: true,
            minHeight: 30,
            customWidths: [50, 65, 55],
            totalSwitches: 3,
            labels: const ['Small', 'Medium', 'Large'],
            onToggle: (index) {
              setState(() {
                selectedSizeIndex = index!;
                updatePrice();
              });
            },
          ),
        ),
        Positioned(
          bottom: 135,
          right: 102,
          height: 30,
          width: 30,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            clipBehavior: Clip.antiAlias,
            child: Material(
              borderRadius: BorderRadius.circular(50),
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  decrementCounter();
                },
                highlightColor: const Color.fromARGB(180, 142, 134, 255),
                splashColor: const Color.fromARGB(180, 148, 88, 207),
                child: Ink(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(120, 74, 71, 62),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.7),
                          width: 0.3,
                          strokeAlign: BorderSide.strokeAlignInside)),
                  child: Center(
                    child: SFIcon(
                      SFIcons.sf_minus,
                      fontSize: 20,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 135,
            right: 72,
            child: Text(
              "$counter",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: "Inter",
                  letterSpacing: 0,
                  fontWeight: FontWeight.w700),
            )),
        Positioned(
          bottom: 135,
          right: 25,
          height: 30,
          width: 30,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            clipBehavior: Clip.antiAlias,
            child: Material(
              borderRadius: BorderRadius.circular(50),
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  incrementCounter();
                },
                highlightColor: const Color.fromARGB(180, 142, 134, 255),
                splashColor: const Color.fromARGB(180, 148, 88, 207),
                child: Ink(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(120, 74, 71, 62),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.7),
                            width: 0.3,
                            strokeAlign: BorderSide.strokeAlignInside)),
                    child: Center(
                      child: SFIcon(
                        SFIcons.sf_plus,
                        fontSize: 20,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    )),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 55,
          left: 25,
          right: 25,
          child: MyGradientButtonWidget(
            width: 204,
            height: 50,
            borderStroke: 2,
            onPressed: () {},
            borderRadius: BorderRadius.circular(10),
            child: Text.rich(
              TextSpan(
                  text: "Add to order for ",
                  style: Theme.of(context).textTheme.titleLarge,
                  children: <InlineSpan>[
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Text(
                        "${String.fromCharCodes(Runes('\u20B3'))}",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 23),
                      ),
                    ),
                    TextSpan(
                      text: " ${currentPrice.toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}
