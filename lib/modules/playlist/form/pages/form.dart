import 'package:flutter/cupertino.dart';
import 'package:my_playlist/constants/ui.constant.dart';
import 'package:my_playlist/enums/form.enum.dart';
import 'package:my_playlist/views/buttons/back.dart';

// ANCHOR Playlist Form Page
class PlaylistFormPage extends StatefulWidget {
  final FormModeEnum mode;

  // ANCHOR Constructor
  const PlaylistFormPage({
    super.key,
    required this.mode,
  });

  // ANCHOR Create State
  @override
  State<PlaylistFormPage> createState() {
    return _PlaylistFormPageState();
  }
}

// ANCHOR Playlist Form Page State
class _PlaylistFormPageState extends State<PlaylistFormPage> {
  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Create Playlist',
        ),
        automaticallyImplyLeading: false,
        leading: BackButton(),
      ),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: EdgeInsets.only(
                top: UI_SPACING_CONSTANT,
                bottom:
                    MediaQuery.of(context).padding.bottom + UI_SPACING_CONSTANT,
                left: UI_SPACING_CONSTANT,
                right: UI_SPACING_CONSTANT,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CupertinoTextField(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
