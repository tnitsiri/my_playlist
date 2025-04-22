import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:my_playlist/constants/ui.constant.dart';
import 'package:my_playlist/models/playlist.model.dart';
import 'package:my_playlist/models/song.model.dart';
import 'package:my_playlist/modules/common/image/default.dart';
import 'package:my_playlist/modules/common/image/placeholder.dart';
import 'package:my_playlist/modules/playlist/playlist/pages/playlist.dart';
import 'package:my_playlist/stores/player.store.dart';
import 'package:my_playlist/styles/common.style.dart';
import 'package:my_playlist/utils/common.util.dart';

// ANCHOR Playlist Card View
class PlaylistCardView extends StatefulWidget {
  final PlaylistModel playlist;
  final PlayerStore playerStore;

  // ANCHOR Constructor
  const PlaylistCardView({
    super.key,
    required this.playlist,
    required this.playerStore,
  });

  // ANCHOR Create State
  @override
  State<PlaylistCardView> createState() {
    return _PlaylistCardViewState();
  }
}

// ANCHOR Playlist Card View State
class _PlaylistCardViewState extends State<PlaylistCardView> {
  // ANCHOR Toggle
  void _toggle({
    required bool isPlaying,
  }) {
    if (isPlaying) {
      widget.playerStore.audioHandler.pause();
    } else {
      if (widget.playlist.songs.isNotEmpty) {
        widget.playerStore.play(
          playlist: widget.playlist,
          songs: widget.playlist.songs,
        );
      } else {
        widget.playerStore.clear();
      }
    }
  }

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
    return Observer(
      builder: (
        BuildContext context,
      ) {
        PlaylistModel? playlist = widget.playerStore.playlist;

        return StreamBuilder<MediaItem?>(
          stream: widget.playerStore.audioHandler.mediaItem,
          builder: (
            BuildContext context,
            AsyncSnapshot<MediaItem?> snapshot,
          ) {
            MediaItem? mediaItem = snapshot.data;

            return StreamBuilder<PlaybackState>(
              stream: widget.playerStore.audioHandler.playbackState,
              builder: (
                BuildContext context,
                AsyncSnapshot<PlaybackState> snapshot,
              ) {
                PlaybackState? state = snapshot.data;

                bool isSelected = false;
                bool isPlaying = false;
                String playing = '';

                if (playlist != null && playlist.id == widget.playlist.id) {
                  isSelected = true;

                  if (state != null && state.playing) {
                    isPlaying = true;
                  }

                  if (mediaItem != null) {
                    SongModel? song =
                        widget.playlist.songs.firstWhereOrNull((e) {
                      return e.url == mediaItem.id;
                    });

                    if (song != null) {
                      playing =
                          '${song.songTitle} - ${song.artistsName.join(', ')}';
                    }
                  }
                }

                return Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? CupertinoTheme.of(context).primaryColor.withAlpha(
                              opacityToAlphaUtil(0.1),
                            )
                        : null,
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: CupertinoColors.systemGrey5,
                      ),
                    ),
                  ),
                  child: CupertinoButton(
                    minSize: 0,
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.zero,
                    onPressed: _view,
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: UI_SPACING_CONSTANT,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 72,
                            margin: EdgeInsets.only(
                              right: UI_SPACING_CONSTANT,
                            ),
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
                                          if (widget
                                              .playlist.songs.isNotEmpty) {
                                            SongModel? song = widget
                                                .playlist.songs
                                                .firstWhereOrNull((e) {
                                              return e.thumbnail != null;
                                            });

                                            if (song != null &&
                                                song.thumbnail != null) {
                                              return CachedNetworkImage(
                                                imageUrl: song.thumbnail!,
                                                placeholder: (
                                                  BuildContext context,
                                                  String url,
                                                ) {
                                                  return ImagePlaceholder(
                                                    width: constraints.maxWidth,
                                                    height:
                                                        constraints.maxHeight,
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
                                          }

                                          return ImageDefault();
                                        },
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
                                  widget.playlist.title,
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
                                Text(
                                  '${widget.playlist.songs.length} Songs',
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: UI_SPACING_CONSTANT,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        playing,
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
                          CupertinoButton(
                            minSize: 0,
                            padding: EdgeInsets.zero,
                            borderRadius: BorderRadius.zero,
                            onPressed: () => _toggle(
                              isPlaying: isPlaying,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(
                                UI_SPACING_CONSTANT,
                              ),
                              child: Builder(
                                builder: (
                                  BuildContext context,
                                ) {
                                  IconData icon = AntDesign.playcircleo;

                                  if (isPlaying) {
                                    icon = AntDesign.pausecircleo;
                                  }

                                  return Icon(
                                    icon,
                                    size: 26,
                                    color:
                                        CupertinoTheme.of(context).primaryColor,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
