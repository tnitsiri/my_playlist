import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_playlist/constants/ui.constant.dart';
import 'package:my_playlist/cubits/doing.cubit.dart';
import 'package:my_playlist/enums/form.enum.dart';
import 'package:my_playlist/models/playlist.model.dart';
import 'package:my_playlist/services/api.service.dart';
import 'package:my_playlist/services/app.service.dart';
import 'package:my_playlist/services/notify.service.dart';
import 'package:my_playlist/views/buttons/back.dart';
import 'package:provider/provider.dart';

// ANCHOR Playlist Form Page
class PlaylistFormPage extends StatefulWidget {
  final FormModeEnum mode;

  // ANCHOR Constructor
  const PlaylistFormPage({
    super.key,
    required this.mode,
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
        alignment: Alignment.topCenter,
      );
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

    if (playlist == null) {
      return;
    }
  }

  // ANCHOR Providers
  void _providers() {
    _apiService = Provider.of<ApiService>(
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
    }

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          title,
        ),
        automaticallyImplyLeading: false,
        leading: BackButton(),
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
                      vertical: 12,
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
                  CupertinoButton(
                    color: CupertinoTheme.of(context).primaryColor,
                    onPressed: _save,
                    child: Text(
                      button,
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
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
