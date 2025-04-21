import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconly/iconly.dart';
import 'package:my_playlist/constants/ui.constant.dart';
import 'package:my_playlist/models/playlist.model.dart';
import 'package:my_playlist/models/search.result.model.dart';
import 'package:my_playlist/modules/song/add/views/result.dart';
import 'package:my_playlist/modules/song/add/views/save.dart';
import 'package:my_playlist/services/api.service.dart';
import 'package:my_playlist/services/notify.service.dart';
import 'package:my_playlist/views/buttons/close.dart';
import 'package:provider/provider.dart';

// ANCHOR Song Add Page
class SongAddPage extends StatefulWidget {
  final PlaylistModel playlist;

  // ANCHOR Constructor
  const SongAddPage({
    super.key,
    required this.playlist,
  });

  // ANCHOR Create State
  @override
  State<SongAddPage> createState() {
    return _SongAddPageState();
  }
}

// ANCHOR Song Add Page State
class _SongAddPageState extends State<SongAddPage> {
  // ANCHOR State
  final StreamController<List<SearchResultModel>>
      _searchResultsStreamController =
      StreamController<List<SearchResultModel>>();

  final StreamController<bool> _searchQueryingStreamController =
      StreamController<bool>();

  final TextEditingController _qController = TextEditingController();
  final List<String> _songsId = [];

  late ApiService _apiService;

  // ANCHOR Search
  Future<void> _search(
    String text,
  ) async {
    String q = text.trim();

    if (q.isEmpty) {
      _searchResultsStreamController.add([]);
      _searchQueryingStreamController.add(
        false,
      );
    } else {
      _searchQueryingStreamController.add(
        true,
      );

      try {
        Response response = await _apiService.dio.get(
          'song/search',
          queryParameters: {
            'q': q,
          },
        );

        List<SearchResultModel> results = (response.data['results'] as List)
            .map(
              (d) => SearchResultModel.fromJson(d),
            )
            .toList();

        _searchResultsStreamController.add(
          results,
        );
      } on DioException catch (e) {
        _searchResultsStreamController.add([]);

        if (e.response != null &&
            e.response?.data != null &&
            e.response?.data is Map &&
            e.response?.data['eMessage'] is String) {
          NotifyService.error(
            message: e.response?.data['eMessage'],
          );
        } else {
          NotifyService.error(
            message: 'Unable to search wanted songs.',
          );
        }
      } catch (e) {
        _searchResultsStreamController.add([]);

        NotifyService.error();
      } finally {
        _searchQueryingStreamController.add(
          false,
        );

        if (_qController.text.trim().isEmpty) {
          _searchResultsStreamController.add([]);
        }
      }
    }
  }

  // ANCHOR Select
  void _select({
    required SearchResultModel result,
  }) {
    int index = _songsId.indexWhere((e) {
      return e == result.songId;
    });

    if (index > -1) {
      if (mounted) {
        setState(() {
          _songsId.removeAt(
            index,
          );
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _songsId.add(
            result.songId,
          );
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
    _searchResultsStreamController.close();
    _searchQueryingStreamController.close();
    _qController.dispose();

    super.dispose();
  }

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Add Songs',
        ),
        automaticallyImplyLeading: false,
        trailing: ButtonClose(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(
              UI_SPACING_CONSTANT,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: CupertinoColors.systemGrey6,
                ),
              ),
            ),
            child: CupertinoTextField(
              placeholder: 'Search songs from Youtube',
              controller: _qController,
              maxLength: 50,
              autofocus: true,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              clearButtonMode: OverlayVisibilityMode.editing,
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
              onChanged: _search,
              prefix: StreamBuilder<bool>(
                stream: _searchQueryingStreamController.stream,
                initialData: false,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<bool> snapshot,
                ) {
                  Widget child = Icon(
                    IconlyLight.search,
                    size: 22,
                  );

                  if (snapshot.hasData && snapshot.data == true) {
                    child = SpinKitRing(
                      color: CupertinoTheme.of(context).primaryColor,
                      size: 19,
                      lineWidth: 1.6,
                    );
                  }

                  return Container(
                    width: 48,
                    height: 26,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 1,
                          color: CupertinoColors.systemGrey3,
                        ),
                      ),
                    ),
                    child: Center(
                      child: child,
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                StreamBuilder<List<SearchResultModel>>(
                  stream: _searchResultsStreamController.stream,
                  initialData: [],
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<SearchResultModel>> snapshot,
                  ) {
                    List<SearchResultModel> results = [];

                    if (snapshot.hasData) {
                      results = snapshot.data!;
                    }

                    return SliverPadding(
                      padding: EdgeInsets.only(
                        bottom: _songsId.isEmpty
                            ? MediaQuery.of(context).padding.bottom
                            : 0,
                      ),
                      sliver: SliverList.builder(
                        itemCount: results.length,
                        itemBuilder: (
                          BuildContext context,
                          int index,
                        ) {
                          SearchResultModel result = results[index];

                          bool isSelected = _songsId.contains(result.songId);
                          bool isLast = index == results.length - 1;

                          return SongAddResultView(
                            key: ValueKey(
                              result.id,
                            ),
                            result: result,
                            isSelected: isSelected,
                            isLast: isLast,
                            onPressed: () => _select(
                              result: result,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          if (_songsId.isNotEmpty) ...[
            SongAddSaveView(
              playlist: widget.playlist,
              songsId: _songsId,
              clear: () {
                if (mounted) {
                  setState(() {
                    _songsId.clear();
                  });
                }
              },
            ),
          ],
        ],
      ),
    );
  }
}
