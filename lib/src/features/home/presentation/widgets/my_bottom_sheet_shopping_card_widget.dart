import 'dart:ui';

import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jp_design_app/src/core/my_gradient_button_widget.dart';
import 'package:jp_design_app/src/features/home/data/items.dart';
import 'package:jp_design_app/src/features/home/data/shopping_card.dart';
import 'package:jp_design_app/src/features/home/domain/item.dart';
import 'package:jp_design_app/src/features/home/domain/shopping_card_details.dart';
import 'package:jp_design_app/src/features/home/presentation/widgets/my_shopping_card_list_widget.dart';
import 'package:smooth_corner/smooth_corner.dart';

import 'package:toggle_switch/toggle_switch.dart';

void myBottomSheetShoppingCardWidget(BuildContext context, Map shoppingCard) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return MyModalBottomSheet(context: context, shoppingCard: shoppingCard);
    },
  );
}

class MyModalBottomSheet extends StatefulWidget {
  const MyModalBottomSheet({
    super.key,
    required this.context,
    required this.shoppingCard,
  });

  final BuildContext context;
  final Map shoppingCard;

  @override
  State<MyModalBottomSheet> createState() => _MyModalBottomSheetState();
}

// Positioned(
//   bottom: 55,
//   left: 25,
//   right: 25,
//   child: MyGradientButtonWidget(
//     width: 204,
//     height: 50,
//     borderStroke: 2,
//     onPressed: () {},
//     borderRadius: BorderRadius.circular(10),
//     child: Text.rich(
//       TextSpan(
//           text: "Add to order for ",
//           style: Theme.of(context).textTheme.titleLarge,
//           children: <InlineSpan>[
//             WidgetSpan(
//               alignment: PlaceholderAlignment.middle,
//               child: Text(
//                 "${String.fromCharCodes(Runes('\u20B3'))}",
//                 style: Theme.of(context)
//                     .textTheme
//                     .titleLarge!
//                     .copyWith(fontSize: 23),
//               ),
//             ),
//             TextSpan(
//               text: " ${currentPrice.toStringAsFixed(2)}",
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//           ]),
//     ),
//   ),
// ),

class _MyModalBottomSheetState extends State<MyModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          height: 852,
          width: 393,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: const EdgeInsets.all(16),
        ),
        Positioned(
            bottom: -20,
            height: 890,
            width: 393,
            child: Padding(
              padding: const EdgeInsets.all(21.0),
              child: ListView.builder(
                  itemCount: shoppingCard.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return MyShoppingCardListWidget(
                        item: shoppingCard.keys.toList()[index]);
                  }),
            )),
        Positioned(
          top: 0,
          height: 200,
          width: 393,
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.fromARGB(255, 59, 69, 160),
                      Colors.transparent
                    ])),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          height: 200,
          width: 393,
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                      Color.fromARGB(255, 202, 130, 165),
                      Colors.transparent
                    ])),
              ),
            ),
          ),
        ),
        Positioned(
          top: 60,
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
                highlightColor: const Color.fromARGB(130, 59, 69, 160),
                splashColor: const Color.fromARGB(130, 59, 69, 160),
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
          bottom: 55,
          left: 25,
          right: 25,
          child: MyGradientButtonWidget(
              width: 204,
              height: 50,
              borderStroke: 2,
              onPressed: () {},
              borderRadius: BorderRadius.circular(10),
              child: Text("data")),
        ),
      ],
    );
  }
}


// Eski foto

        // Positioned(
        //   bottom: -40,
        //   right: 0,
        //   child: Opacity(
        //       opacity: 0.1,
        //       child: Image.asset(
        //         "assets/details/T2.png",
        //       )),
        // ),


// önceki blur
// Positioned(
//   top: 0,
//   height: 119,
//   width: 393,
//   child: ClipRRect(
//     clipBehavior: Clip.antiAlias,
//     borderRadius: BorderRadius.circular(10),
//     child: BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
//       child: Container(
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//               Color.fromARGB(130, 202, 130, 165),
//               Colors.transparent
//             ])),
//       ),
//     ),
//   ),
// ),


// vor listview
         // Positioned(
            // bottom: -20,
            // height: 890,
            // width: 393,
            // child: Padding(
            //   padding: const EdgeInsets.all(21.0),
            //   child: SingleChildScrollView(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         MyShoppingCardListWidget(
            //           item: shoppingCard.keys.toList()[0],
            //         ),
            //         MyShoppingCardListWidget(
            //           item: shoppingCard.keys.toList()[0],
            //         ),
            //         MyShoppingCardListWidget(
            //           item: shoppingCard.keys.toList()[0],
            //         ),
            //         MyShoppingCardListWidget(
            //           item: shoppingCard.keys.toList()[0],
            //         ),
            //         MyShoppingCardListWidget(
            //           item: shoppingCard.keys.toList()[0],
            //         ),
            //         MyShoppingCardListWidget(
            //           item: shoppingCard.keys.toList()[0],
            //         ),
            //         MyShoppingCardListWidget(
            //           item: shoppingCard.keys.toList()[0],
            //         ),
            //         MyShoppingCardListWidget(
            //           item: shoppingCard.keys.toList()[0],
            //         ),
            //       ],
            //     ),
            //   ),
            // )),