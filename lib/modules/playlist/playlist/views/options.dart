import 'package:custom_pop_up_menu_fork/custom_pop_up_menu.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:iconly/iconly.dart';
import 'package:my_playlist/cubits/doing.cubit.dart';
import 'package:my_playlist/models/playlist.model.dart';
import 'package:my_playlist/plugins/action_sheet/action_sheet.dart';
import 'package:my_playlist/plugins/custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:my_playlist/services/api.service.dart';
import 'package:my_playlist/services/notify.service.dart';
import 'package:my_playlist/stores/playlist.store.dart';
import 'package:provider/provider.dart';

// ANCHOR Profile Header Options
class PlaylistOptions extends StatefulWidget {
  final PlaylistModel playlist;

  // ANCHOR Constructor
  const PlaylistOptions({
    super.key,
    required this.playlist,
  });

  // ANCHOR Create State
  @override
  State<PlaylistOptions> createState() {
    return _PlaylistOptionsState();
  }
}

// ANCHOR Profile Header Options State
class _PlaylistOptionsState extends State<PlaylistOptions> {
  // ANCHOR State
  final CustomPopupMenuController _controller = CustomPopupMenuController();

  late ApiService _apiService;
  late PlaylistStore _playlistStore;

  // ANCHOR Remove
  void _remove() async {
    _controller.hideMenu();

    List<ActionSheetModel> items = [
      ActionSheetModel(
        text: 'Delete Playlist',
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
          title: 'Are you sure you want to delete this playlist?',
          items: items,
        );
      },
    );

    if (isConfirmed == null || !mounted) {
      return;
    }

    DoingCubit doingCubit = context.read<DoingCubit>();

    doingCubit.show();

    try {
      await _apiService.dio.delete(
        'playlist/${widget.playlist.id}/remove',
      );

      _playlistStore.fetchList();

      NotifyService.toast(
        message: 'Playlist was removed successfully.',
      );

      if (mounted) {
        Navigator.of(context).pop();
      }
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

  // ANCHOR Dispose
  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomPopupMenu(
          controller: _controller,
          pressType: PressType.singleClick,
          arrowSize: CustomPopupMenuConfig.arrowSize,
          arrowColor: CustomPopupMenuConfig.arrowColor,
          barrierColor: CustomPopupMenuConfig.barrierColor,
          horizontalMargin: CustomPopupMenuConfig.horizontalMargin,
          verticalMargin: CustomPopupMenuConfig.verticalMargin,
          menuBuilder: () {
            return PopupMenuBuilder(
              children: [
                PopupMenuItem(
                  text: 'Update',
                  icon: Icon(
                    IconlyLight.edit,
                    size: CustomPopupMenuConfig.iconSize,
                    color: CustomPopupMenuConfig.iconColor,
                  ),
                  onPressed: () {},
                ),
                PopupMenuItem(
                  text: 'Delete',
                  icon: Icon(
                    IconlyLight.delete,
                    size: CustomPopupMenuConfig.iconSize,
                    color: CustomPopupMenuConfig.dangerColor,
                  ),
                  danger: true,
                  last: true,
                  onPressed: _remove,
                ),
              ],
            );
          },
          child: Icon(
            Feather.more_horizontal,
            size: 24,
          ),
        ),
      ],
    );
  }
}
