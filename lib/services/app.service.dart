import 'package:flutter/cupertino.dart';
import 'package:grock/grock.dart';

// ANCHOR App Service
class AppService {
  // ANCHOR Unfocus
  static void unfocus() {
    FocusScopeNode focusScopeNode = FocusScope.of(
      Grock.context,
    );

    if (focusScopeNode.hasPrimaryFocus == false &&
        focusScopeNode.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
