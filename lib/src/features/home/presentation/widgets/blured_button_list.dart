import 'package:flutter/material.dart';
import 'package:jp_design_app/src/data/items.dart';
import 'package:jp_design_app/src/core/presentation/widgets/my_blur_button_widget.dart';
import 'package:flutter_sficon/flutter_sficon.dart';

List<MyBlurButtonWidget> getBluredButtons(
    Function(int) onSelectBlurButton, int selectedBlurButtonIndex) {
  Color selectedButtonBgColor = const Color.fromARGB(255, 231, 200, 230);
  Color unselectedButtonBgColor = Colors.white.withOpacity(0.1);
  Color selectedButtonTextColor = Colors.black.withOpacity(0.7);
  Color unselectedButtonTextColor = Colors.white.withOpacity(0.4);

  TextStyle buttonTextStyle(int index) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w800,
      color: selectedBlurButtonIndex == index
          ? selectedButtonTextColor
          : unselectedButtonTextColor,
      letterSpacing: -0.5,

      fontFamily: "Inter",
    );
  }

  return [
    MyBlurButtonWidget(
      onPressed: () {
        // onSelectBlurButton(0);
      },
      borderRadius: 40,
      width: 145,
      height: 43,
      backgroundColor: unselectedButtonBgColor,
      withBorder: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SFIcon(
            SFIcons.sf_takeoutbag_and_cup_and_straw,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: unselectedButtonTextColor,
          ),
          Text(
            " All categories ",
            style: buttonTextStyle(0), // 0
          ),
          SFIcon(
            SFIcons.sf_chevron_down,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: unselectedButtonTextColor,
          ),
        ],
      ),
    ),
    MyBlurButtonWidget(
      onPressed: () {
        onSelectBlurButton(1);
      },
      borderRadius: 40,
      width: 90,
      height: 43,
      backgroundColor: selectedBlurButtonIndex == 1
          ? selectedButtonBgColor
          : unselectedButtonBgColor,
      withBorder: selectedBlurButtonIndex == 1 ? false : true,
      child: Text(
        items.keys.toList()[0],
        style: buttonTextStyle(1),
      ),
    ),
    MyBlurButtonWidget(
      onPressed: () {
        onSelectBlurButton(2);
      },
      borderRadius: 40,
      width: 90,
      height: 43,
      backgroundColor: selectedBlurButtonIndex == 2
          ? selectedButtonBgColor
          : unselectedButtonBgColor,
      withBorder: selectedBlurButtonIndex == 2 ? false : true,
      child: Text(
        items.keys.toList()[1],
        style: buttonTextStyle(2),
      ),
    ),
    MyBlurButtonWidget(
      onPressed: () {
        onSelectBlurButton(3);
      },
      borderRadius: 40,
      width: 90,
      height: 43,
      backgroundColor: selectedBlurButtonIndex == 3
          ? selectedButtonBgColor
          : unselectedButtonBgColor,
      withBorder: selectedBlurButtonIndex == 3 ? false : true,
      child: Text(
        items.keys.toList()[2],
        style: buttonTextStyle(3),
      ),
    ),
    MyBlurButtonWidget(
      onPressed: () {
        onSelectBlurButton(4);
      },
      borderRadius: 40,
      width: 90,
      height: 43,
      backgroundColor: selectedBlurButtonIndex == 4
          ? selectedButtonBgColor
          : unselectedButtonBgColor,
      withBorder: selectedBlurButtonIndex == 4 ? false : true,
      child: Text(
        items.keys.toList()[3],
        style: buttonTextStyle(4),
      ),
    ),
  ];
}
