import 'package:flutter/cupertino.dart';
import 'package:my_playlist/constants/ui.constant.dart';
import 'package:my_playlist/models/playlist.model.dart';

// ANCHOR Playlist Card View
class PlaylistCardView extends StatelessWidget {
  final PlaylistModel playlist;

  // ANCHOR Constructor
  const PlaylistCardView({
    super.key,
    required this.playlist,
  });

  // ANCHOR View
  void _view() {}

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: CupertinoColors.systemRed,
        ),
      ),
      child: CupertinoButton(
        minSize: 0,
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.zero,
        onPressed: _view,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: UI_SPACING_CONSTANT,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: CupertinoColors.systemPurple,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 80,
                child: AspectRatio(
                  aspectRatio: 1,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      playlist.title,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
