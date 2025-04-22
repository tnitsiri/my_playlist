import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:grock/grock.dart';
import 'package:iconly/iconly.dart';
import 'package:my_playlist/constants/ui.constant.dart';
import 'package:my_playlist/cubits/doing.cubit.dart';
import 'package:my_playlist/models/playlist.model.dart';
import 'package:my_playlist/models/song.model.dart';
import 'package:my_playlist/modules/common/image/default.dart';
import 'package:my_playlist/modules/common/image/placeholder.dart';
import 'package:my_playlist/plugins/action_sheet/model.dart';
import 'package:my_playlist/plugins/action_sheet/view.dart';
import 'package:my_playlist/services/api.service.dart';
import 'package:my_playlist/services/notify.service.dart';
import 'package:my_playlist/stores/player.store.dart';
import 'package:my_playlist/styles/common.style.dart';
import 'package:my_playlist/utils/common.util.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// ANCHOR Song Card View
class SongCardView extends StatefulWidget {
  final PlaylistModel playlist;
  final SongModel song;
  final int index;
  final ApiService apiService;
  final PlayerStore playerStore;
  final VoidCallback play;
  final VoidCallback removed;

  // ANCHOR Constructor
  const SongCardView({
    super.key,
    required this.playlist,
    required this.song,
    required this.index,
    required this.apiService,
    required this.playerStore,
    required this.play,
    required this.removed,
  });

  // ANCHOR Create State
  @override
  State<SongCardView> createState() {
    return _SongCardViewState();
  }
}

// ANCHOR Song Card View State
class _SongCardViewState extends State<SongCardView> {
  // ANCHOR Toggle
  void _toggle({
    required bool isPlaying,
  }) async {
    if (widget.playerStore.playlist != null &&
        widget.playerStore.playlist!.id == widget.playlist.id) {
      if (isPlaying) {
        widget.playerStore.audioHandler.pause();
      } else {
        await widget.playerStore.audioHandler.skipToQueueItem(
          widget.index,
        );

        widget.playerStore.audioHandler.play();
      }
    } else {
      widget.play();
    }
  }

  // ANCHOR Remove
  void _remove(
    BuildContext context,
  ) async {
    List<ActionSheetModel> items = [
      ActionSheetModel(
        text: 'Delete Song',
        value: true,
        danger: true,
      ),
    ];

    bool? isConfirmed = await showCupertinoModalPopup(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return ActionSheet.from(
          context,
          title: 'Are you sure you want to delete this song?',
          items: items,
        );
      },
    );

    if (isConfirmed == null || !mounted || !Grock.context.mounted) {
      return;
    }

    DoingCubit doingCubit = Grock.context.read<DoingCubit>();

    doingCubit.show();

    try {
      await widget.apiService.dio.put(
        'song/remove',
        data: {
          'playlistId': widget.playlist.id,
          'songId': widget.song.id,
        },
      );

      NotifyService.toast(
        message: 'Song was removed successfully.',
      );

      widget.removed();
    } on DioException catch (e) {
      if (e.response != null &&
          e.response?.data != null &&
          e.response?.data is Map &&
          e.response?.data['eMessage'] is String) {
        NotifyService.error(
          message: e.response?.data['eMessage'],
        );
      } else {
        NotifyService.error();
      }
    } catch (e) {
      NotifyService.error();
    } finally {
      doingCubit.hide();
    }
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
            bool isSelected = false;

            if (snapshot.data != null &&
                playlist != null &&
                playlist.id == widget.playlist.id) {
              MediaItem mediaItem = snapshot.data!;

              if (mediaItem.id == widget.song.url) {
                isSelected = true;
              }
            }

            return StreamBuilder<PlaybackState>(
              stream: widget.playerStore.audioHandler.playbackState,
              builder: (
                BuildContext context,
                AsyncSnapshot<PlaybackState> snapshot,
              ) {
                bool isPlaying = false;

                if (snapshot.data != null) {
                  PlaybackState state = snapshot.data!;

                  if (isSelected && state.playing) {
                    isPlaying = true;
                  }
                }

                return Slidable(
                  key: ValueKey(
                    widget.song.id,
                  ),
                  closeOnScroll: true,
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    extentRatio: 0.3,
                    children: [
                      CustomSlidableAction(
                        backgroundColor: CupertinoColors.systemRed,
                        onPressed: _remove,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              IconlyLight.delete,
                              size: 25,
                              color: CupertinoColors.white,
                            ),
                            FittedBox(
                              child: Text(
                                'Delete',
                                style: CommonStyle.textStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: CupertinoColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  child: Container(
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
                      onPressed: () => _toggle(
                        isPlaying: isPlaying,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: UI_SPACING_CONSTANT,
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
                                                imageUrl:
                                                    widget.song.thumbnail!,
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
                                            color:
                                                CupertinoColors.black.withAlpha(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                            Builder(
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
                          ],
                        ),
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
