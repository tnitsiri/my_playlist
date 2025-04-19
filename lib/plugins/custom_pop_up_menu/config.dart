import 'package:flutter/cupertino.dart';
import 'package:my_playlist/utils/common.util.dart';

// ANCHOR Custom Popup Menu Config
abstract class CustomPopupMenuConfig {
  // ANCHOR Arrow Size
  static double arrowSize = 20;

  // ANCHOR Arrow Color
  static Color arrowColor = CupertinoColors.black;

  // ANCHOR Barrier Color
  static Color barrierColor = CupertinoColors.black.withAlpha(
    opacityToAlphaUtil(
      0.1,
    ),
  );

  // ANCHOR Horizontal Margin
  static double horizontalMargin = 0;

  // ANCHOR Vertical Margin
  static double verticalMargin = 0;

  // ANCHOR Icon Size
  static double iconSize = 23;

  // ANCHOR Icon Color
  static Color iconColor = Color(0xFFCCCCCC);

  // ANCHOR Danger Color
  static Color dangerColor = CupertinoColors.systemRed;
}
