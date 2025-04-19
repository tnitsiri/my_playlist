import 'package:flutter/cupertino.dart';
import 'package:my_playlist/styles/common.style.dart';
import 'package:my_playlist/views/buttons/simple.dart';

import 'config.dart';

// ANCHOR Popup Menu Item
class PopupMenuItem extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Widget icon;
  final VoidCallback onPressed;
  final bool danger;
  final bool last;

  // ANCHOR Constructor
  const PopupMenuItem({
    super.key,
    required this.text,
    this.textColor,
    required this.icon,
    required this.onPressed,
    this.danger = false,
    this.last = false,
  });

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return ButtonSimple(
      onPressed: onPressed,
      child: Container(
        constraints: BoxConstraints(
          minWidth: 160,
        ),
        padding: const EdgeInsets.only(
          top: 6.5,
          bottom: 6.5,
          left: 16,
          right: 10,
        ),
        decoration: BoxDecoration(
          color: CupertinoColors.black,
          border: Border(
            bottom: BorderSide(
              width: last ? 0 : 0.5,
              color:
                  last ? CupertinoColors.transparent : const Color(0xFF666666),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Builder(
                builder: (
                  BuildContext context,
                ) {
                  Color color = const Color(0xFFCCCCCC);

                  if (textColor != null) {
                    color = textColor!;
                  } else {
                    if (danger) {
                      color = CustomPopupMenuConfig.dangerColor;
                    }
                  }

                  return Text(
                    text,
                    style: CommonStyle.textStyle.copyWith(
                      fontSize: 14,
                      color: color,
                      letterSpacing: 0.3,
                    ),
                  );
                },
              ),
            ),
            Container(
              width: 28,
              height: 28,
              margin: const EdgeInsets.only(
                left: 30,
              ),
              child: Center(
                child: icon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
