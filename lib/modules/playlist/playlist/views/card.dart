import 'package:flutter/cupertino.dart';
import 'package:my_playlist/constants/ui.constant.dart';
import 'package:my_playlist/models/playlist.model.dart';
import 'package:my_playlist/modules/playlist/playlist/pages/playlist.dart';

// ANCHOR Playlist Card View
class PlaylistCardView extends StatefulWidget {
  final PlaylistModel playlist;

  // ANCHOR Constructor
  const PlaylistCardView({
    super.key,
    required this.playlist,
  });

  // ANCHOR Create State
  @override
  State<PlaylistCardView> createState() {
    return _PlaylistCardViewState();
  }
}

// ANCHOR Playlist Card View State
class _PlaylistCardViewState extends State<PlaylistCardView> {
  // ANCHOR View
  void _view() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (
          BuildContext context,
        ) {
          return PlaylistPage(
            playlist: widget.playlist,
          );
        },
      ),
    );
  }

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
              SizedBox(
                width: 50,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey6,
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.playlist.title,
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
