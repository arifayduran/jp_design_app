import 'package:flutter/material.dart';
import 'package:jp_design_app/src/domain/item.dart';
import 'package:jp_design_app/src/features/shopping_card/domain/shopping_card_details.dart';

class ShoppingCardSum {
  static double totalSum(
      ValueNotifier<Map<Item, ShoppingCardDetails>> shoppingListNotifier) {
    return shoppingListNotifier.value.entries.map((entry) {
      double multiplier;
      switch (entry.value.selectedSizeIndex) {
        case 0:
          multiplier = 0.6;
          break;
        case 1:
          multiplier = 0.8;
          break;
        case 2:
          multiplier = 1.0;
          break;
        default:
          multiplier = 1.0;
      }
      return entry.value.amount * entry.key.price * multiplier;
    }).fold(0.0, (sum, element) => sum + element);
  }
}
