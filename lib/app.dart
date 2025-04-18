import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grock/grock.dart';
import 'package:my_playlist/cubits/doing.cubit.dart';
import 'package:my_playlist/modules/home/home/pages/home.dart';
import 'package:my_playlist/root.dart';
import 'package:my_playlist/styles/common.style.dart';

// ANCHOR App
class App extends StatelessWidget {
  // ANCHOR Constructor
  const App({
    super.key,
  });

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DoingCubit>(
          create: (
            BuildContext context,
          ) {
            return DoingCubit();
          },
        ),
      ],
      child: CupertinoApp(
        theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: const Color(0xFFFD5602),
          barBackgroundColor: const Color(0xFFF7F8F9),
          textTheme: CupertinoTextThemeData(
            textStyle: CommonStyle.textStyle,
            navTitleTextStyle: CommonStyle.navTitleTextStyle,
            navLargeTitleTextStyle: CommonStyle.navLargeTitleTextStyle,
          ),
        ),
        navigatorKey: Grock.navigationKey,
        home: HomePage(),
        builder: (
          BuildContext context,
          Widget? child,
        ) {
          return Root(
            child: child,
          );
        },
      ),
    );
  }
}
