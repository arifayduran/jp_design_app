import 'package:flutter/material.dart';
import 'package:jp_design_app/src/features/home/data/items.dart';

import 'package:jp_design_app/src/features/home/data/recommend_items.dart';
import 'package:jp_design_app/src/features/home/presentation/blured_button_list.dart';
import 'package:jp_design_app/src/features/home/presentation/widgets/my_bottom_sheet_widget.dart';
import 'package:jp_design_app/src/features/home/presentation/widgets/my_recommend_card_widget.dart';
import 'package:jp_design_app/src/features/home/presentation/widgets/my_top_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedBlurButtonIndex = 1;
  List<String> categoryList = items.keys.toList();

  void onSelectBlurButton(int index) {
    setState(() {
      selectedBlurButtonIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double logicWidth = 393;
    double logicHeight = 852;

    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          color: const Color.fromARGB(255, 45, 42, 34),
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            child: Container(
              width: logicWidth,
              height: logicHeight,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background/bg_mainscreen.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 75,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    width: double.infinity,
                    child: Text(
                      "Choose Your Favorite\nSnack",
                      style: Theme.of(context).textTheme.displayLarge!,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: 68,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 21),
                        child: Row(
                          children: getBluredButtons(
                                  onSelectBlurButton, selectedBlurButtonIndex)
                              .map((button) {
                            return SizedBox(
                              child: button,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 21.0),
                      child: Row(
                        children: items[
                                    categoryList[selectedBlurButtonIndex - 1]]!
                                .isNotEmpty
                            ? items[categoryList[selectedBlurButtonIndex - 1]]!
                                .map((item) {
                                return MyTopCardWidget(
                                  onPressed: () {
                                    print('Add to Order button pressed');
                                    myBottomSheetWidget(context, item);
                                  },
                                  assetPath: item.assetPath ??
                                      "assets/graphics/noimage.png",
                                  title: item.title,
                                  subtitle: item.subtitle,
                                  price: item.price,
                                  reviews: item.reviews,
                                );
                              }).toList()
                            : [
                                MyTopCardWidget(
                                  onPressed: () {},
                                  assetPath: "assets/graphics/noimage.png",
                                  title: "No Items in List",
                                  subtitle: "Example for no items in the list",
                                  price: 0.00,
                                  reviews: 0.0,
                                ),
                              ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    width: 393,
                    child: const Text(
                      " We Recommend",
                      style: TextStyle(
                          fontSize: 15.5,
                          color: Colors.white,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 21.0),
                        child: Row(
                          children: recommendItems.isNotEmpty
                              ? recommendItems.map((item) {
                                  return MyRecommendCardWidget(
                                    onTap: () {
                                      myBottomSheetWidget(context, item);
                                    },
                                    assetPath: item.assetPath ??
                                        "assets/graphics/noimage.png",
                                    title: item.title,
                                    subtitle: item.subtitle,
                                    price: item.price,
                                    likedCount: item.likedCount,
                                  );
                                }).toList()
                              : [
                                  MyRecommendCardWidget(
                                    onTap: () {},
                                    assetPath: "assets/graphics/noimage.png",
                                    title: "No Recommendations",
                                    subtitle: "Example for no recommendations",
                                    price: 0.00,
                                    likedCount: 0,
                                  ),
                                ],
                        )),
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
