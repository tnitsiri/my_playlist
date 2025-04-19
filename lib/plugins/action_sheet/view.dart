import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';
import 'package:my_playlist/styles/common.style.dart';

import 'model.dart';

// ANCHOR Action Sheet
class ActionSheet {
  // ANCHOR From
  static CupertinoActionSheet from(
    BuildContext context, {
    required String title,
    required List<ActionSheetModel> items,
  }) {
    ActionSheetModel? danger = items.firstWhereOrNull(
      (e) => e.danger,
    );

    return CupertinoActionSheet(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: CommonStyle.textStyle.fontFamily,
          fontFamilyFallback: CommonStyle.textStyle.fontFamilyFallback,
          letterSpacing: 0.3,
          color: CupertinoColors.inactiveGray,
        ),
      ),
      actions: [
        ...items.map((e) {
          Color textColor = const Color(0xFFCCCCCC);

          if (e.danger) {
            textColor = CupertinoColors.systemRed;
          } else if (e.textColor != null) {
            textColor = e.textColor!;
          }

          return CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(
                context,
                e.value,
              );
            },
            child: Text(
              e.text,
              style: CommonStyle.textStyle.copyWith(
                fontSize: 14.5,
                fontWeight: FontWeight.w500,
                color: textColor,
                letterSpacing: 0.3,
              ),
            ),
          );
        }),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () => Navigator.pop(context),
        child: Text(
          'Cancel',
          style: CommonStyle.textStyle.copyWith(
            fontSize: 14.5,
            fontWeight: FontWeight.w500,
            color: danger != null
                ? CupertinoColors.black
                : CupertinoColors.systemRed,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
