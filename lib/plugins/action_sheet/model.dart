import 'dart:ui';

// ANCHOR Action Sheet Model
class ActionSheetModel {
  String text;
  Color? textColor;
  dynamic value;
  bool danger;

  // ANCHOR Constructor
  ActionSheetModel({
    required this.text,
    this.textColor,
    required this.value,
    this.danger = false,
  });
}
