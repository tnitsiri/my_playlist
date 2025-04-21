import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:my_playlist/constants/ui.constant.dart';
import 'package:my_playlist/models/song.model.dart';
import 'package:my_playlist/modules/common/image/default.dart';
import 'package:my_playlist/modules/common/image/placeholder.dart';
import 'package:my_playlist/styles/common.style.dart';
import 'package:my_playlist/utils/common.util.dart';

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
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: CupertinoColors.systemGrey5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CupertinoButton(
              minSize: 0,
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.zero,
              onPressed: () {},
              child: Container(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: UI_SPACING_CONSTANT,
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
                  spacing: UI_SPACING_CONSTANT,
                  children: [
                    SizedBox(
                      width: 72,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: CupertinoColors.systemGrey6,
                                ),
                                child: LayoutBuilder(
                                  builder: (
                                    BuildContext context,
                                    BoxConstraints constraints,
                                  ) {
                                    if (widget.song.thumbnail != null) {
                                      return CachedNetworkImage(
                                        imageUrl: widget.song.thumbnail!,
                                        placeholder: (
                                          BuildContext context,
                                          String url,
                                        ) {
                                          return ImagePlaceholder(
                                            width: constraints.maxWidth,
                                            height: constraints.maxHeight,
                                          );
                                        },
                                        errorWidget: (
                                          BuildContext context,
                                          String url,
                                          Object error,
                                        ) {
                                          return ImageDefault();
                                        },
                                      );
                                    }

                                    return ImageDefault();
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: 3,
                                right: 3,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.black.withAlpha(
                                      opacityToAlphaUtil(0.65),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  child: Text(
                                    widget.song.durationText,
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w500,
                                      color: CupertinoColors.white,
                                      letterSpacing: 0.1,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: CupertinoTheme.of(context)
                                        .primaryColor
                                        .withAlpha(
                                          opacityToAlphaUtil(0.4),
                                        ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Feather.pause,
                                      size: 26,
                                      color: CupertinoColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                            widget.song.songTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CommonStyle.textStyle.copyWith(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w600,
                              color: CupertinoColors.black,
                              letterSpacing: 0.2,
                              height: 1.4,
                            ),
                          ),
                          if (widget.song.artistsName.isNotEmpty) ...[
                            Text(
                              widget.song.artistsName.join(', '),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: CommonStyle.textStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF636363),
                                letterSpacing: 0.2,
                                height: 1.5,
                              ),
                            ),
                          ],
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: UI_SPACING_CONSTANT,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.song.albumName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: CommonStyle.textStyle.copyWith(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF6C6C6C),
                                    letterSpacing: 0.2,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 60,
            padding: EdgeInsets.only(
              right: UI_SPACING_CONSTANT,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: CupertinoColors.activeGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
