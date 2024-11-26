import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jp_design_app/src/config/logical_sizes.dart';
import 'package:jp_design_app/src/core/presentation/widgets/my_gradient_button_widget.dart';
import 'package:jp_design_app/src/core/presentation/widgets/my_small_circle_button_widget.dart';
import 'package:jp_design_app/src/features/add_to_order/application/generate_review_stars.dart';
import 'package:jp_design_app/src/features/add_to_order/application/get_ingredients_icons.dart';
import 'package:jp_design_app/src/features/shopping_card/data/shopping_card.dart';
import 'package:jp_design_app/src/domain/item.dart';
import 'package:jp_design_app/src/features/shopping_card/domain/shopping_card_details.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:toggle_switch/toggle_switch.dart';

void showMyBottomSheetAddOrderWidget(
    BuildContext context, Item item, ValueNotifier<int> itemCountNotifier) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return MyBottomSheetAddOrderWidget(
          context: context, item: item, itemCountNotifier: itemCountNotifier);
    },
  );
}

class MyBottomSheetAddOrderWidget extends StatefulWidget {
  const MyBottomSheetAddOrderWidget({
    super.key,
    required this.context,
    required this.item,
    required this.itemCountNotifier,
  });

  final BuildContext context;
  final Item item;
  final ValueNotifier<int> itemCountNotifier;

  @override
  State<MyBottomSheetAddOrderWidget> createState() =>
      MyBottomSheetAddOrderWidgetState();
}

class MyBottomSheetAddOrderWidgetState
    extends State<MyBottomSheetAddOrderWidget> {
  Icon favIcon = Icon(Icons.favorite_border,
      size: 17, color: Colors.white.withOpacity(0.4));
  bool isFavorite = false;
  int favCountNew = 0;
  int selectedSizeIndex = 2;
  double basePrice = 0.0;
  double currentPrice = 0.0;
  double itemPriceTotal = 0.0;
  int amount = 1;

  @override
  void initState() {
    super.initState();
    favCountNew = widget.item.likedCount;
    basePrice = widget.item.price;
    updatePrice();
  }

  void incrementAmount() {
    setState(() {
      amount++;
      updatePrice();
    });
  }

  void decrementAmount() {
    setState(() {
      amount--;
      if (amount <= 1) {
        amount = 1;
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
    currentPrice = widget.item.price * sizeMultiplier;
    itemPriceTotal = basePrice * sizeMultiplier * amount;
  }

  void _addToShoppingCart(Item item, int amount, int selectedSizeIndex) {
    setState(() {
      if (shoppingCard.containsKey(item)) {
        shoppingCard[item]!.amount += amount;
        shoppingCard[item]!.selectedSizeIndex = selectedSizeIndex;
      } else {
        shoppingCard[item] = ShoppingCardDetails(
          amount: amount,
          selectedSizeIndex: selectedSizeIndex,
        );
      }
      widget.itemCountNotifier.value =
          shoppingCard.values.fold(0, (total, card) => total + card.amount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.center,
          child: SizedBox(
            width: logicWidth,
            height: logicHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: logicHeight * 0.8849,
                    width: logicWidth,
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(16),
                  ),
                ),
                Positioned(
                  top: -33,
                  height: 400,
                  width: 400,
                  child: Image.asset(
                    widget.item.assetPath ?? "assets/graphics/noimage.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                    top: 118,
                    right: 12,
                    child: MySmallCircleButtonWidget(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    )),
                Positioned(
                  top: 275,
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
                              height: 7,
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
                                            color:
                                                Colors.white.withOpacity(0.4));
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
                              height: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/Coin-ada-big.svg",
                                  // ignore: deprecated_member_use
                                  color: Colors.white,
                                  height: 20,
                                ),
                                Text(
                                  currentPrice.toStringAsFixed(2),
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
                              height: 30,
                              color: Color.fromARGB(110, 201, 182, 221),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 115,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Ingredients",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -0.4,
                                          color: Color.fromARGB(
                                              255, 167, 167, 167),
                                          fontFamily: "Inter",
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children:
                                            getIngredientsIcons(widget.item),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 115,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Reviews",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -0.4,
                                          color: Color.fromARGB(
                                              255, 167, 167, 167),
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
                                            widget.item.reviews
                                                .toStringAsFixed(1),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              letterSpacing: -0.4,
                                              color: Color.fromARGB(
                                                  255, 167, 167, 167),
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
                              height: 12,
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
                    activeBgColor: const [Color.fromARGB(255, 108, 108, 108)],
                    inactiveBgColor: const Color.fromARGB(140, 85, 85, 85),
                    activeFgColor: Colors.white,
                    inactiveFgColor: Colors.white.withOpacity(0.6),
                    initialLabelIndex: selectedSizeIndex,
                    fontSize: 11.3,
                    dividerMargin: 9,
                    radiusStyle: true,
                    minHeight: 30,
                    customWidths: const [50, 65, 55],
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
                    child: MySmallCircleButtonWidget(
                      size: 30,
                      onTap: decrementAmount,
                      child: SFIcon(
                        SFIcons.sf_minus,
                        fontSize: 20,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    )),
                Positioned(
                    bottom: 135,
                    right: 72,
                    child: Text(
                      "$amount",
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
                    child: MySmallCircleButtonWidget(
                      onTap: incrementAmount,
                      child: SFIcon(
                        SFIcons.sf_plus,
                        fontSize: 20,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    )),
                Positioned(
                  bottom: 55,
                  left: 25,
                  right: 25,
                  child: MyGradientButtonWidget(
                    width: 204,
                    height: 50,
                    borderStroke: 2,
                    onPressed: () {
                      _addToShoppingCart(
                          widget.item, amount, selectedSizeIndex);
                      Navigator.of(context).pop();
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Text.rich(
                      TextSpan(
                          text: "Add to order for  ",
                          style: Theme.of(context).textTheme.titleLarge,
                          children: <InlineSpan>[
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Text(
                                String.fromCharCodes(Runes('\u20B3')),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: 23),
                              ),
                            ),
                            TextSpan(
                              text: " ${itemPriceTotal.toStringAsFixed(2)}",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
