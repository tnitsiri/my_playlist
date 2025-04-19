import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_playlist/models/playlist.model.dart';
import 'package:my_playlist/modules/playlist/playlist/views/options.dart';
import 'package:my_playlist/services/api.service.dart';
import 'package:my_playlist/services/notify.service.dart';
import 'package:my_playlist/stores/playlist.store.dart';
import 'package:my_playlist/views/buttons/back.dart';
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
  late PlaylistStore _playlistStore;

  late PlaylistModel _playlist;

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

  // ANCHOR Init
  void _init() {
    if (mounted) {
      setState(() {
        _playlist = widget.playlist;
      });
    }
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
    _init();
    _fetch();

    super.initState();
  }

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          _playlist.title,
        ),
        automaticallyImplyLeading: false,
        leading: BackButton(),
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
        ],
      ),
    );
  }
}
