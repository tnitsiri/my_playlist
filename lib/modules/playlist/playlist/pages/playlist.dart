import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_playlist/constants/ui.constant.dart';
import 'package:my_playlist/models/playlist.model.dart';
import 'package:my_playlist/models/song.model.dart';
import 'package:my_playlist/modules/playlist/playlist/views/options.dart';
import 'package:my_playlist/modules/song/add/pages/add.dart';
import 'package:my_playlist/modules/song/song/views/card.dart';
import 'package:my_playlist/services/api.service.dart';
import 'package:my_playlist/services/notify.service.dart';
import 'package:my_playlist/stores/player.store.dart';
import 'package:my_playlist/views/buttons/back.dart';
import 'package:my_playlist/views/buttons/simple.dart';
import 'package:provider/provider.dart';

// ANCHOR Playlist Page
class PlaylistPage extends StatefulWidget {
  final PlaylistModel playlist;

  // ANCHOR Constructor
  const PlaylistPage({
    super.key,
    required this.playlist,
  });

  // ANCHOR Create State
  @override
  State<PlaylistPage> createState() {
    return _PlaylistPageState();
  }
}

// ANCHOR Playlist Page State
class _PlaylistPageState extends State<PlaylistPage> {
  // ANCHOR State
  late ApiService _apiService;
  late PlayerStore _playerStore;

  late PlaylistModel _playlist;

  List<SongModel> _songs = [];

  // ANCHOR Fetch
  Future<bool> _fetch({
    bool showError = true,
  }) async {
    bool isSuccess = false;

    try {
      Response response = await _apiService.dio.get(
        'playlist/${widget.playlist.id}/info',
      );

      PlaylistModel playlist = PlaylistModel.fromJson(
        response.data['playlist'],
      );

      if (mounted) {
        setState(() {
          _playlist = playlist;
          _songs = playlist.songs;
        });
      }

      isSuccess = true;
    } on DioException catch (e) {
      if (e.response?.statusCode != 401) {
        if (e.response?.statusCode == 404) {
          if (mounted) {
            NotifyService.error(
              message: 'Playlist information not found.',
            );

            Navigator.of(context).pop();
          }
        } else {
          if (showError) {
            NotifyService.error(
              message: 'Unable to fetch playlist information.',
            );
          }
        }
      } else {
        if (showError) {
          NotifyService.error();
        }
      }
    } catch (e) {
      if (showError) {
        NotifyService.error();
      }
    }

    return isSuccess;
  }

  // ANCHOR Refresh
  Future<void> _refresh() async {
    await _fetch();
  }

  // ANCHOR Add Songs
  void _addSongs() async {
    bool? isSuccess = await showCupertinoModalPopup(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return SongAddPage(
          playlist: _playlist,
        );
      },
    );

    if (isSuccess == null || !isSuccess) {
      return;
    }

    _fetch();
  }

  // ANCHOR Init
  void _init() {
    if (mounted) {
      setState(() {
        _playlist = widget.playlist;
        _songs = widget.playlist.songs;
      });
    }
  }

  // ANCHOR Providers
  void _providers() {
    _apiService = Provider.of<ApiService>(
      context,
      listen: false,
    );

    _playerStore = Provider.of<PlayerStore>(
      context,
      listen: false,
    );
  }

  // ANCHOR Init State
  @override
  void initState() {
    _providers();
    _init();
    _fetch();

    super.initState();
  }

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return Stack(
      children: [
        CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(
              _playlist.title,
            ),
            automaticallyImplyLeading: false,
            leading: ButtonBack(),
            trailing: PlaylistOptions(
              playlist: _playlist,
              refetch: _fetch,
            ),
          ),
          child: CustomScrollView(
            slivers: [
              CupertinoSliverRefreshControl(
                onRefresh: _refresh,
              ),
              if (_songs.isNotEmpty) ...[
                SliverPadding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom,
                  ),
                  sliver: SliverList.builder(
                    itemCount: _songs.length,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      SongModel song = _songs[index];

                      return SongCardView(
                        key: ValueKey(
                          song.id,
                        ),
                        playlist: _playlist,
                        song: song,
                        index: index,
                        playerStore: _playerStore,
                        play: () {
                          _playerStore.play(
                            playlist: _playlist,
                            songs: _songs,
                            index: index,
                          );
                        },
                      );
                    },
                  ),
                ),
              ] else ...[
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 50,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: CupertinoColors.activeOrange,
                      ),
                    ),
                    child: ButtonSimple(
                      onPressed: _addSongs,
                      child: Text(
                        'Add Songs',
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (_songs.isNotEmpty) ...[
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + UI_SPACING_CONSTANT,
            right: UI_SPACING_CONSTANT,
            child: ClipOval(
              child: Material(
                color: CupertinoTheme.of(context).primaryColor,
                child: InkWell(
                  onTap: _addSongs,
                  child: SizedBox(
                    width: 62,
                    height: 62,
                    child: Icon(
                      Icons.add,
                      size: 30,
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
