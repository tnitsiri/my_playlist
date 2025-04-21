import 'package:flutter/cupertino.dart';
import 'package:my_playlist/constants/ui.constant.dart';
import 'package:my_playlist/models/song.model.dart';

// ANCHOR Song Card View
class SongCardView extends StatefulWidget {
  final SongModel song;

  // ANCHOR Constructor
  const SongCardView({
    super.key,
    required this.song,
  });

  // ANCHOR Create State
  @override
  State<SongCardView> createState() {
    return _SongCardViewState();
  }
}

// ANCHOR Song Card View State
class _SongCardViewState extends State<SongCardView> {
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
        onPressed: () {},
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
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
