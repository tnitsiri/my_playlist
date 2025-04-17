import 'package:flutter/cupertino.dart';

// ANCHOR Common Style
abstract class CommonStyle {
  // ANCHOR Text Style
  static TextStyle textStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: CupertinoColors.black,
  );

  // ANCHOR Nav Title Text Style
  static TextStyle navTitleTextStyle = textStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );

  // ANCHOR Nav Large Title Text Style
  static TextStyle navLargeTitleTextStyle = navTitleTextStyle.copyWith(
    fontSize: 30,
  );
}
