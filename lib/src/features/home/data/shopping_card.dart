import 'package:jp_design_app/src/features/home/data/items.dart';
import 'package:jp_design_app/src/features/home/domain/item.dart';
import 'package:jp_design_app/src/features/home/domain/shopping_card_details.dart';

Map<Item, ShoppingCardDetails> shoppingCard = {
  items["Salty"]![0]: ShoppingCardDetails(amount: 3, selectedSizeIndex: 2),
  items["Salty"]![1]: ShoppingCardDetails(amount: 3, selectedSizeIndex: 2),
  items["Salty"]![2]: ShoppingCardDetails(amount: 3, selectedSizeIndex: 2),
  items["Sweet"]![0]: ShoppingCardDetails(amount: 3, selectedSizeIndex: 2),
  items["Sweet"]![0]: ShoppingCardDetails(amount: 3, selectedSizeIndex: 2),
  items["Ice Cream's"]![0]:
      ShoppingCardDetails(amount: 3, selectedSizeIndex: 2),
  items["Ice Cream's"]![1]:
      ShoppingCardDetails(amount: 3, selectedSizeIndex: 2),
  items["Ice Cream's"]![2]:
      ShoppingCardDetails(amount: 3, selectedSizeIndex: 2),
  items["Ice Cream's"]![3]:
      ShoppingCardDetails(amount: 3, selectedSizeIndex: 2),
  items["Ice Cream's"]![4]:
      ShoppingCardDetails(amount: 3, selectedSizeIndex: 2),
};
