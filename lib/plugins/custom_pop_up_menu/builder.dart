import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:my_playlist/utils/common.util.dart';

// ANCHOR Popup Menu Builder
class PopupMenuBuilder extends StatelessWidget {
  final List<Widget> children;
  final double _borderRadius = 10;

  // ANCHOR Constructor
  const PopupMenuBuilder({
    super.key,
    required this.children,
  });

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      transform: Matrix4.translationValues(0, -1, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          _borderRadius,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          _borderRadius,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF4C4C4C).withAlpha(
              opacityToAlphaUtil(
                0.3,
              ),
            ),
            borderRadius: BorderRadius.circular(
              _borderRadius,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  _borderRadius,
                ),
              ),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
