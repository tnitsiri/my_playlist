import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconly/iconly.dart';
import 'package:mobx/mobx.dart';
import 'package:my_playlist/enums/form.enum.dart';
import 'package:my_playlist/models/playlist.model.dart';
import 'package:my_playlist/modules/playlist/form/pages/form.dart';
import 'package:my_playlist/modules/playlist/playlist/pages/playlist.dart';
import 'package:my_playlist/modules/playlist/playlist/views/card.dart';
import 'package:my_playlist/services/api.service.dart';
import 'package:my_playlist/services/notify.service.dart';
import 'package:my_playlist/stores/playlist.store.dart';
import 'package:my_playlist/views/buttons/button.dart';
import 'package:provider/provider.dart';

// ANCHOR Home Page
class HomePage extends StatefulWidget {
  // ANCHOR Constructor
  const HomePage({
    super.key,
  });

  // ANCHOR Create State
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

// ANCHOR Home Page State
class _HomePageState extends State<HomePage> {
  // ANCHOR State
  late ApiService _apiService;
  late PlaylistStore _playlistStore;

  late ReactionDisposer _playlistFetchListDisposer;

  List<PlaylistModel> _playlists = [];

  // ANCHOR Fetch
  Future<bool> _fetch() async {
    bool isSuccess = false;

    try {
      Response response = await _apiService.dio.get(
        'playlist/list',
      );

      List<PlaylistModel> playlists = (response.data['playlists'] as List)
          .map(
            (d) => PlaylistModel.fromJson(d),
          )
          .toList();

      if (mounted) {
        setState(() {
          _playlists = playlists;
        });
      }

      isSuccess = true;
    } on DioException catch (e) {
      if (e.response != null &&
          e.response?.data != null &&
          e.response?.data is Map &&
          e.response?.data['eMessage'] is String) {
        NotifyService.error(
          message: e.response?.data['eMessage'],
        );
      } else {
        NotifyService.error(
          message: 'Unable to fetch playlist.',
        );
      }
    } catch (e) {
      NotifyService.error();
    }

    return isSuccess;
  }

  // ANCHOR Refetch
  Future<void> _refetch() async {
    await _fetch();
  }

  // ANCHOR Refresh
  Future<void> _refresh() async {
    await _refetch();
  }

  // ANCHOR Create
  void _create() async {
    PlaylistModel? playlist = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (
          BuildContext context,
        ) {
          return PlaylistFormPage(
            mode: FormModeEnum.create,
          );
        },
      ),
    );

    if (playlist == null || !mounted) {
      return;
    }

    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (
          BuildContext context,
        ) {
          return PlaylistPage(
            playlist: playlist,
          );
        },
      ),
    );
  }

  // ANCHOR Stores
  void _stores() {
    _playlistFetchListDisposer = reaction(
      (_) => _playlistStore.fetchListToken,
      (String? token) {
        if (token != null) {
          _refetch();
        }
      },
    );
  }

  // ANCHOR Providers
  void _providers() {
    _apiService = Provider.of<ApiService>(
      context,
      listen: false,
    );

    _playlistStore = Provider.of<PlaylistStore>(
      context,
      listen: false,
    );
  }

  // ANCHOR Init State
  @override
  void initState() {
    _providers();
    _stores();
    _fetch();

    super.initState();
  }

  // ANCHOR Dispose
  @override
  void dispose() {
    _playlistFetchListDisposer();

    super.dispose();
  }

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text(
              'My Playlist',
            ),
            trailing: Button(
              icon: IconlyLight.plus,
              onPressed: _create,
            ),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: _refresh,
          ),
          SliverList.builder(
            itemCount: _playlists.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              PlaylistModel playlist = _playlists[index];

              return PlaylistCardView(
                key: ValueKey(
                  playlist.id,
                ),
                playlist: playlist,
              );
            },
          ),
        ],
      ),
    );
  }
}
