import 'package:flutter/material.dart';
import 'package:jp_design_app/src/domain/item.dart';

List<Widget> getIngredientsIcons(Item item) {
  List<Widget> icons = [];
  if (item.isGluten) {
    icons.add(Padding(
      padding: const EdgeInsets.only(right: 7),
      child: Image.asset('assets/icons/gluten_icon.png', width: 20, height: 20),
    ));
  }
  if (item.isSugar) {
    icons.add(Padding(
        padding: const EdgeInsets.only(right: 7),
        child:
            Image.asset('assets/icons/sugar_icon.png', width: 20, height: 20)));
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
        child:
            Image.asset('assets/icons/kcal_icon.png', width: 20, height: 20)));
  }
  return icons;
}
