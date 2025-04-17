import 'package:flutter/cupertino.dart';
import 'package:my_playlist/home/pages/home.dart';
import 'package:my_playlist/styles/common.style.dart';

// ANCHOR App
class App extends StatelessWidget {
  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        textTheme: CupertinoTextThemeData(
          textStyle: CommonStyle.textStyle,
          navTitleTextStyle: CommonStyle.navTitleTextStyle,
          navLargeTitleTextStyle: CommonStyle.navLargeTitleTextStyle,
        ),
      ),
      home: HomePage(),
    );
  }
}
