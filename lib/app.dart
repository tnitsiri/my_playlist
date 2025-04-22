import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grock/grock.dart';
import 'package:my_playlist/cubits/doing.cubit.dart';
import 'package:my_playlist/modules/home/home/pages/home.dart';
import 'package:my_playlist/plugins/audio/a.dart';
import 'package:my_playlist/root.dart';
import 'package:my_playlist/services/api.service.dart';
import 'package:my_playlist/stores/player.store.dart';
import 'package:my_playlist/stores/playlist.store.dart';
import 'package:my_playlist/styles/common.style.dart';
import 'package:provider/provider.dart';

// ANCHOR App
class App extends StatelessWidget {
  final AudioPlayerHandler audioHandler;

  // ANCHOR Constructor
  const App({
    super.key,
    required this.audioHandler,
  });

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(
          create: (_) {
            return ApiService();
          },
        ),
        Provider<PlayerStore>(
          create: (_) {
            return PlayerStore(
              audioHandler,
            );
          },
        ),
        Provider<PlaylistStore>(
          create: (_) {
            return PlaylistStore();
          },
        ),
      ],
      child: MultiBlocProvider(
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
            barBackgroundColor: CupertinoColors.systemGrey6,
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
      ),
    );
  }
}
