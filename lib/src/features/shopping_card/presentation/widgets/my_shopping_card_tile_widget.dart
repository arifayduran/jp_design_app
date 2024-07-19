import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:jp_design_app/src/features/shopping_card/data/shopping_card.dart';
import 'package:jp_design_app/src/domain/item.dart';
import 'package:jp_design_app/src/features/shopping_card/domain/shopping_card_details.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MyShoppingCardTileWidget extends StatefulWidget {
  const MyShoppingCardTileWidget({
    super.key,
    required this.item,
    required this.itemCountNotifier,
    required this.shoppingListNotifier,
  });

  final Item item;
  final ValueNotifier<int> itemCountNotifier;
  final ValueNotifier<Map<Item, ShoppingCardDetails>> shoppingListNotifier;

  @override
  State<MyShoppingCardTileWidget> createState() =>
      _MyShoppingCardTileWidgetState();
}

class _MyShoppingCardTileWidgetState extends State<MyShoppingCardTileWidget> {
  late double _currentPrice;
  late double _itemPriceTotal;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _shoppingListUpdate();
    });
    _updatePrice();
  }

  void _shoppingListUpdate() {
    if (mounted) {
      Future.microtask(() {
        if (mounted) {
          setState(() {
            widget.shoppingListNotifier.value = Map.from(shoppingCard);
          });
        }
      });
    }
  }

  void _updateItemCount() {
    setState(() {
      widget.itemCountNotifier.value =
          shoppingCard.values.fold(0, (total, card) => total + card.amount);
    });
  }

  void _incrementAmount() {
    setState(() {
      shoppingCard[widget.item]!.amount++;
      _updateItemCount();
      _updatePrice();
      _shoppingListUpdate();
    });
  }

  void _decrementAmountUntilDelete() {
    setState(() {
      if (shoppingCard.containsKey(widget.item) &&
          shoppingCard[widget.item] != null) {
        shoppingCard[widget.item]!.amount--;
        if (shoppingCard[widget.item]!.amount <= 0) {
          shoppingCard.remove(widget.item);
        }
      }
      _shoppingListUpdate();
      _updateItemCount();
      _updatePrice();
    });
  }

  void _saveToggle(int index) {
    setState(() {
      shoppingCard[widget.item]!.selectedSizeIndex = index;
      _updatePrice();
      _shoppingListUpdate();
    });
  }

  void _updatePrice() {
    if (shoppingCard[widget.item] == null) return;

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
    _shoppingListUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          margin: const EdgeInsets.only(top: 0),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.4),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(175, 59, 69, 160),
                    Color.fromARGB(175, 148, 88, 207),
                    Color.fromARGB(175, 202, 130, 165)
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
                    height: 6,
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
                          initialLabelIndex: widget.shoppingListNotifier
                              .value[widget.item]!.selectedSizeIndex,
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
