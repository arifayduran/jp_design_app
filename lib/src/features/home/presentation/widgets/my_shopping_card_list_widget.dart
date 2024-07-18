import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:jp_design_app/src/core/my_gradient_button_widget.dart';
import 'package:jp_design_app/src/features/home/data/shopping_card.dart';
import 'package:jp_design_app/src/features/home/domain/item.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MyShoppingCardListWidget extends StatefulWidget {
  const MyShoppingCardListWidget({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  State<MyShoppingCardListWidget> createState() =>
      _MyShoppingCardListWidgetState();
}

class _MyShoppingCardListWidgetState extends State<MyShoppingCardListWidget> {
  double _currentPrice = 0.0;
  double _itemPriceTotal = 0.0;

  @override
  void initState() {
    super.initState();
    _updatePrice();
  }

  void _incrementAmount() {
    setState(() {
      shoppingCard[widget.item]!.amount++;
      _updatePrice();
    });
  }

  void _decrementAmountUntilDelete() {
    setState(() {
      if (shoppingCard.containsKey(widget.item)) {
        shoppingCard[widget.item]!.amount--;
        if (shoppingCard[widget.item]!.amount <= 0) {
          shoppingCard.remove(widget.item);
        }
      }

      _updatePrice();
    });
  }

  void _saveToggle(int index) {
    setState(() {
      shoppingCard[widget.item]!.selectedSizeIndex = index;
      _updatePrice();
    });
  }

  void _updatePrice() {
    double sizeMultiplier;
    switch (shoppingCard[widget.item]!.selectedSizeIndex) {
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
    _currentPrice = widget.item.price * sizeMultiplier;
    _itemPriceTotal =
        widget.item.price * sizeMultiplier * shoppingCard[widget.item]!.amount;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          margin: const EdgeInsets.only(top: 15),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.4),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(130, 59, 69, 160),
                    Color.fromARGB(130, 148, 88, 207),
                    Color.fromARGB(130, 202, 130, 165)
                  ])),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: Opacity(
                  opacity: 0.7,
                  child: Image.asset(
                    widget.item.assetPath ?? "assets/graphics/noimage.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: 228,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.item.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                height: 0,
                                letterSpacing: -0.8,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          "  ${String.fromCharCodes(Runes('\u20B3'))} ${_itemPriceTotal.toStringAsFixed(2)}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              height: 0,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 228,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.item.subtitle,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                height: 0,
                                letterSpacing: -0.8,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Text(
                          "     ${String.fromCharCodes(Runes('\u20B3'))} ${_currentPrice.toStringAsFixed(2)}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              height: 0,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 228,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ToggleSwitch(
                          activeBgColor: const [
                            Color.fromARGB(130, 59, 69, 160)
                          ],
                          inactiveBgColor:
                              const Color.fromARGB(140, 85, 85, 85),
                          activeFgColor: Colors.white,
                          inactiveFgColor: Colors.white.withOpacity(0.6),
                          initialLabelIndex:
                              shoppingCard[widget.item]!.selectedSizeIndex,
                          fontSize: 11.3,
                          dividerMargin: 7.5,
                          radiusStyle: true,
                          minHeight: 25,
                          customWidths: const [40, 40, 40],
                          totalSwitches: 3,
                          labels: const ['S', 'M', 'L'],
                          onToggle: (index) {
                            _saveToggle(index!);
                          },
                        ),
                        SizedBox(
                          width: 75,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                clipBehavior: Clip.antiAlias,
                                child: Material(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      _decrementAmountUntilDelete();
                                    },
                                    highlightColor:
                                        const Color.fromARGB(130, 59, 69, 160),
                                    splashColor:
                                        const Color.fromARGB(130, 59, 69, 160),
                                    child: Ink(
                                      height: 26,
                                      width: 26,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              120, 74, 71, 62),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                              width: 0.1,
                                              strokeAlign: BorderSide
                                                  .strokeAlignInside)),
                                      child: Center(
                                        child: SFIcon(
                                          SFIcons.sf_minus,
                                          fontSize: 16,
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "${shoppingCard[widget.item]!.amount}",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 18,
                                    fontFamily: "Inter",
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w400),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                clipBehavior: Clip.antiAlias,
                                child: Material(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      _incrementAmount();
                                    },
                                    highlightColor:
                                        const Color.fromARGB(130, 59, 69, 160),
                                    splashColor:
                                        const Color.fromARGB(130, 59, 69, 160),
                                    child: Ink(
                                        height: 26,
                                        width: 26,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                120, 74, 71, 62),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                color: Colors.white
                                                    .withOpacity(0.7),
                                                width: 0.1,
                                                strokeAlign: BorderSide
                                                    .strokeAlignInside)),
                                        child: Center(
                                          child: SFIcon(
                                            SFIcons.sf_plus,
                                            fontSize: 16,
                                            color:
                                                Colors.white.withOpacity(0.7),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
