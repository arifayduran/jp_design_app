import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:jp_design_app/src/config/logical_sizes.dart';
import 'package:jp_design_app/src/core/presentation/widgets/my_gradient_button_widget.dart';
import 'package:jp_design_app/src/features/shopping_card/application/shopping_card_sum.dart';
import 'package:jp_design_app/src/features/shopping_card/data/credit.dart';
import 'package:jp_design_app/src/features/shopping_card/data/shopping_card.dart';
import 'package:jp_design_app/src/domain/item.dart';
import 'package:jp_design_app/src/features/shopping_card/domain/shopping_card_details.dart';
import 'package:jp_design_app/src/core/presentation/widgets/blur_gradient.dart';
import 'package:jp_design_app/src/features/shopping_card/presentation/widgets/my_shopping_card_tile_widget.dart';

void showMyBottomSheetShoppingListWidget(
    BuildContext context, ValueNotifier<int> itemCountNotifier) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return MyBottomSheetShoppingCardWidget(
          context: context, itemCountNotifier: itemCountNotifier);
    },
  );
}

class MyBottomSheetShoppingCardWidget extends StatefulWidget {
  const MyBottomSheetShoppingCardWidget({
    super.key,
    required this.context,
    required this.itemCountNotifier,
  });

  final BuildContext context;
  final ValueNotifier<int> itemCountNotifier;

  @override
  State<MyBottomSheetShoppingCardWidget> createState() =>
      _MyBottomSheetShoppingCardWidgetState();
}

class _MyBottomSheetShoppingCardWidgetState
    extends State<MyBottomSheetShoppingCardWidget> {
  late FixedExtentScrollController _scrollController;
  bool _isVisible = false;
  ValueNotifier<Map<Item, ShoppingCardDetails>> shoppingListNotifier =
      ValueNotifier<Map<Item, ShoppingCardDetails>>(shoppingCard);

  @override
  void initState() {
    super.initState();

    int initialIndex = (shoppingCard.length / 2).floor();
    _scrollController = FixedExtentScrollController(initialItem: initialIndex);

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    shoppingListNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.linear,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                width: logicWidth,
                height: logicHeight,
                color: Colors.black.withOpacity(0.2),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -90,
                      child: SizedBox(
                        height: 1000,
                        width: logicWidth,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21.0),
                          child: ValueListenableBuilder<
                              Map<Item, ShoppingCardDetails>>(
                            valueListenable: shoppingListNotifier,
                            builder: (context, shoppingList, _) {
                              // if (shoppingList.isEmpty) {
                              //   return Center(
                              //     child: Text(
                              //       "No items in your Shopping Card",
                              //       style: Theme.of(context).textTheme.bodyLarge,
                              //     ),
                              //   );
                              // }
                              if (shoppingList.isEmpty) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            "No items in your Shopping Card"),
                                        titleTextStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("OK"))
                                        ],
                                      );
                                    },
                                  );
                                });
                                return const SizedBox();
                              } else {
                                return ListWheelScrollView.useDelegate(
                                  controller: _scrollController,
                                  squeeze: 0.92,
                                  diameterRatio: 2,
                                  itemExtent: 110,
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    builder: (context, index) {
                                      return MyShoppingCardTileWidget(
                                          item:
                                              shoppingList.keys.toList()[index],
                                          itemCountNotifier:
                                              widget.itemCountNotifier,
                                          shoppingListNotifier:
                                              shoppingListNotifier);
                                    },
                                    childCount: shoppingList.length,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: BlurGradient(
                        startColor: const Color.fromARGB(255, 202, 130, 165),
                        height: 250,
                        width: logicWidth,
                        blurTotal: 4,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: BlurGradient(
                        startColor: const Color.fromARGB(255, 59, 69, 160),
                        height: 250,
                        width: logicWidth,
                        blurTotal: 4,
                        reverse: true,
                      ),
                    ),
                    Positioned(
                      top: 70,
                      right: 0,
                      left: 0,
                      child: SizedBox(
                        width: logicWidth,
                        height: 30,
                        child: Center(
                          child: Text(
                            "Shopping Card",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 67,
                      right: 25,
                      width: 35,
                      height: 35,
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
                            highlightColor:
                                const Color.fromARGB(130, 59, 69, 160),
                            splashColor: const Color.fromARGB(130, 59, 69, 160),
                            child: Ink(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(120, 74, 71, 62),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.7),
                                  width: 0.3,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 115,
                      left: 29,
                      right: 29,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Credits:",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                          ),
                          Text(
                            "${String.fromCharCodes(Runes('\u20B3'))} ${credit.toStringAsFixed(2)}",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 21,
                      right: 21,
                      child: MyGradientButtonWidget(
                        width: 351,
                        height: 50,
                        borderStroke: 1.5,
                        borderRadius: BorderRadius.circular(10),
                        borderColor: Colors.grey.withOpacity(0.4),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 202, 130, 165),
                            Color.fromARGB(255, 148, 88, 207),
                            Color.fromARGB(255, 59, 69, 160),
                          ],
                        ),
                        shadowColor: Colors.black.withOpacity(0.5),
                        child: ValueListenableBuilder<
                                Map<Item, ShoppingCardDetails>>(
                            valueListenable: shoppingListNotifier,
                            builder: (context, shoppingList, _) {
                              return Text.rich(
                                TextSpan(
                                    text: "Pay with  ",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
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
                                        text:
                                            " ${ShoppingCardSum.totalSum(shoppingListNotifier).toStringAsFixed(2)}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    ]),
                              );
                            }),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Successfully Purchased"),
                                titleTextStyle:
                                    Theme.of(context).textTheme.bodyLarge,
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        shoppingCard = {};
                                        widget.itemCountNotifier.value = 0;
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("OK"))
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
