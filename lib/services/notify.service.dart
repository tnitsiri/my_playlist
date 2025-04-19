import 'package:flutter/cupertino.dart';
import 'package:grock/grock.dart';
import 'package:my_playlist/styles/common.style.dart';

// ANCHOR Notify Service
class NotifyService {
  // ANCHOR Toast
  static void toast({
    required String message,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    Grock.toast(
      text: message,
      textStyle: CommonStyle.textStyle.copyWith(
        fontWeight: FontWeight.w500,
        color: CupertinoColors.black,
      ),
      alignment: alignment,
      duration: const Duration(
        seconds: 3,
      ),
    );
  }

  // ANCHOR Error
  static void error({
    String? message,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    NotifyService.toast(
      message: message ?? 'An error occurred during the operation.',
      alignment: alignment,
    );
  }
}
