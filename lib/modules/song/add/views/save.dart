import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:iconly/iconly.dart';
import 'package:my_playlist/constants/ui.constant.dart';
import 'package:my_playlist/cubits/doing.cubit.dart';
import 'package:my_playlist/models/playlist.model.dart';
import 'package:my_playlist/services/api.service.dart';
import 'package:my_playlist/services/app.service.dart';
import 'package:my_playlist/services/notify.service.dart';
import 'package:my_playlist/stores/playlist.store.dart';
import 'package:my_playlist/views/buttons/block.dart';
import 'package:provider/provider.dart';

// ANCHOR Song Add Save View
class SongAddSaveView extends StatefulWidget {
  final PlaylistModel playlist;
  final List<String> songsId;
  final VoidCallback clear;

  // ANCHOR Constructor
  const SongAddSaveView({
    super.key,
    required this.playlist,
    required this.songsId,
    required this.clear,
  });

  // ANCHOR Create State
  @override
  State<SongAddSaveView> createState() {
    return _SongAddSaveViewState();
  }
}

// ANCHOR Song Add Save View State
class _SongAddSaveViewState extends State<SongAddSaveView> {
  // ANCHOR State
  late ApiService _apiService;
  late PlaylistStore _playlistStore;

  // ANCHOR Save
  void _save() async {
    AppService.unfocus();

    DoingCubit doingCubit = context.read<DoingCubit>();

    doingCubit.show(
      message: 'It may take time longer than usual to process.',
    );

    bool isSuccess = false;

    try {
      await _apiService.dio.post(
        'song/add',
        data: {
          'playlistId': widget.playlist.id,
          'songsId': widget.songsId,
        },
      );

      NotifyService.toast(
        message: 'Songs has been successfully added to playlist.',
      );

      _playlistStore.fetchList();

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
        NotifyService.error();
      }
    } catch (e) {
      NotifyService.error();
    } finally {
      doingCubit.hide();
    }

    if (!isSuccess || !mounted) {
      return;
    }

    Navigator.of(context).pop(
      true,
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

    super.initState();
  }

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.only(
        top: UI_SPACING_CONSTANT,
        bottom: MediaQuery.of(context).padding.bottom > 0
            ? MediaQuery.of(context).padding.bottom
            : UI_SPACING_CONSTANT,
        left: UI_SPACING_CONSTANT,
        right: UI_SPACING_CONSTANT,
      ),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
          top: BorderSide(
            width: 1,
            color: CupertinoColors.systemGrey6,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          Expanded(
            child: ButtonBlock(
              text:
                  'Add ${widget.songsId.length} Song${widget.songsId.length > 1 ? 's' : ''}',
              icon: Ionicons.musical_notes_outline,
              onPressed: _save,
            ),
          ),
          CupertinoButton(
            minSize: 0,
            padding: EdgeInsets.zero,
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(
              8,
            ),
            onPressed: widget.clear,
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: CupertinoTheme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              child: Icon(
                IconlyLight.delete,
                size: 23,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
