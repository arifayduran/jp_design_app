import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:jp_design_app/src/features/shopping_card/data/shopping_card.dart';
import 'package:jp_design_app/src/features/shopping_card/presentation/show_my_bottom_sheet_shopping_list_widget.dart';

class ShoppingCardIconWidget extends StatelessWidget {
  const ShoppingCardIconWidget({
    super.key,
    required this.itemCountNotifier,
  });

  final ValueNotifier<int> itemCountNotifier;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
              onPressed: () {
                if (shoppingCard.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                        child: const Text(
                          "No items in your shopping cart",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(
                        label: 'OK',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Color.fromARGB(190, 220, 143, 219),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                } else {
                  showMyBottomSheetShoppingListWidget(
                      context, itemCountNotifier);
                }
              },
              icon: const SFIcon(
                SFIcons.sf_basket_fill,
                color: Colors.white,
                fontSize: 30,
              )),
        ),
        ValueListenableBuilder<int>(
          valueListenable: itemCountNotifier,
          builder: (context, itemCount, child) {
            if (itemCount == 0) {
              return const SizedBox();
            } else {
              return Positioned(
                right: 10,
                top: -3,
                child: Container(
                  height: 21,
                  width: 21,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 145, 84, 203),
                        Color.fromARGB(255, 187, 65, 148)
                      ]),
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Text(
                      itemCount.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "SF Pro",
                          fontWeight: FontWeight.w900,
                          fontSize: 13),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
