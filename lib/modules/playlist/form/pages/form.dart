import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:my_playlist/constants/ui.constant.dart';
import 'package:my_playlist/cubits/doing.cubit.dart';
import 'package:my_playlist/enums/form.enum.dart';
import 'package:my_playlist/models/playlist.model.dart';
import 'package:my_playlist/services/api.service.dart';
import 'package:my_playlist/services/app.service.dart';
import 'package:my_playlist/services/notify.service.dart';
import 'package:my_playlist/stores/playlist.store.dart';
import 'package:my_playlist/views/buttons/back.dart';
import 'package:my_playlist/views/buttons/block.dart';
import 'package:provider/provider.dart';

// ANCHOR Playlist Form Page
class PlaylistFormPage extends StatefulWidget {
  final FormModeEnum mode;
  final PlaylistModel? playlist;
  final Function? refetch;

  // ANCHOR Constructor
  const PlaylistFormPage({
    super.key,
    required this.mode,
    this.playlist,
    this.refetch,
  });

  // ANCHOR Create State
  @override
  State<PlaylistFormPage> createState() {
    return _PlaylistFormPageState();
  }
}

// ANCHOR Playlist Form Page State
class _PlaylistFormPageState extends State<PlaylistFormPage> {
  // ANCHOR State
  final TextEditingController _titleController = TextEditingController();

  late ApiService _apiService;
  late PlaylistStore _playlistStore;

  // ANCHOR Save
  void _save() async {
    String title = _titleController.text.trim();

    if (title.isEmpty) {
      NotifyService.toast(
        message: 'Please specify playlist title.',
      );

      return;
    }

    DoingCubit doingCubit = context.read<DoingCubit>();

    doingCubit.show();
    AppService.unfocus();

    PlaylistModel? playlist;

    try {
      if (widget.mode == FormModeEnum.create) {
        Response response = await _apiService.dio.post(
          'playlist/create',
          data: {
            'title': title,
          },
        );

        playlist = PlaylistModel.fromJson(
          response.data['playlist'],
        );

        NotifyService.toast(
          message: 'Playlist created successfully.',
        );
      } else if (widget.mode == FormModeEnum.update) {
        Response response = await _apiService.dio.put(
          'playlist/${widget.playlist?.id}/update',
          data: {
            'title': title,
          },
        );

        playlist = PlaylistModel.fromJson(
          response.data['playlist'],
        );

        if (widget.refetch != null) {
          await widget.refetch!();
        }

        NotifyService.toast(
          message: 'Playlist updated successfully.',
        );
      }

      _playlistStore.fetchList();
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

    if (playlist == null || !mounted) {
      return;
    }

    Navigator.of(context).pop(
      playlist,
    );
  }

  // ANCHOR Init
  void _init() {
    if (widget.mode == FormModeEnum.update && widget.playlist != null) {
      PlaylistModel playlist = widget.playlist!;

      if (mounted) {
        setState(() {
          _titleController.text = playlist.title;
        });
      }
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

    super.initState();
  }

  // ANCHOR Dispose
  @override
  void dispose() {
    _titleController.dispose();

    super.dispose();
  }

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    String title = '';
    String button = '';

    if (widget.mode == FormModeEnum.create) {
      title = 'Create Playlist';
      button = 'Create';
    } else if (widget.mode == FormModeEnum.update) {
      title = 'Update Playlist';
      button = 'Update';
    }

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          title,
        ),
        automaticallyImplyLeading: false,
        leading: ButtonBack(),
      ),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: EdgeInsets.only(
                top: UI_SPACING_CONSTANT,
                bottom:
                    MediaQuery.of(context).padding.bottom + UI_SPACING_CONSTANT,
                left: UI_SPACING_CONSTANT,
                right: UI_SPACING_CONSTANT,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: UI_FORM_SPACING_CONSTANT,
                children: [
                  CupertinoTextField(
                    placeholder: 'Playlist title',
                    controller: _titleController,
                    maxLength: 100,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.done,
                    placeholderStyle: TextStyle(
                      color: CupertinoColors.inactiveGray,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 11,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey6,
                      border: Border.all(
                        width: 1,
                        color: CupertinoColors.systemGrey6,
                      ),
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                  ),
                  ButtonBlock(
                    text: button,
                    icon: Ionicons.save_outline,
                    onPressed: _save,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
