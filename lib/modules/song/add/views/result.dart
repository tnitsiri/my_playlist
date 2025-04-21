import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:my_playlist/constants/ui.constant.dart';
import 'package:my_playlist/models/search.result.model.dart';
import 'package:my_playlist/modules/common/image/default.dart';
import 'package:my_playlist/modules/common/image/placeholder.dart';
import 'package:my_playlist/styles/common.style.dart';
import 'package:my_playlist/utils/common.util.dart';

// ANCHOR Song Add Result View
class SongAddResultView extends StatefulWidget {
  final SearchResultModel result;
  final bool isSelected;
  final bool isLast;
  final VoidCallback onPressed;

  // ANCHOR Constructor
  const SongAddResultView({
    super.key,
    required this.result,
    this.isSelected = false,
    this.isLast = false,
    required this.onPressed,
  });

  // ANCHOR Create State
  @override
  State<SongAddResultView> createState() {
    return _SongAddResultViewState();
  }
}

// ANCHOR Song Add Result View State
class _SongAddResultViewState extends State<SongAddResultView> {
  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.zero,
      onPressed: widget.onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: UI_SPACING_CONSTANT,
        ),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? CupertinoTheme.of(context).primaryColor.withAlpha(
                    opacityToAlphaUtil(0.1),
                  )
              : null,
          border: !widget.isLast
              ? Border(
                  bottom: BorderSide(
                    width: 1,
                    color: CupertinoColors.systemGrey5,
                  ),
                )
              : null,
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
                            if (widget.result.thumbnail != null) {
                              return CachedNetworkImage(
                                imageUrl: widget.result.thumbnail!,
                                placeholder: (
                                  BuildContext context,
                                  String url,
                                ) {
                                  return ImagePlaceholder(
                                    width: constraints.maxWidth,
                                    height: constraints.maxHeight,
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
                      if (widget.isSelected) ...[
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: CupertinoTheme.of(context)
                                  .primaryColor
                                  .withAlpha(
                                    opacityToAlphaUtil(0.4),
                                  ),
                            ),
                            child: Center(
                              child: Icon(
                                Feather.check,
                                size: 26,
                                color: CupertinoColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
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
                    widget.result.songTitle,
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
                  if (widget.result.artistsName.isNotEmpty) ...[
                    Text(
                      widget.result.artistsName.join(', '),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: UI_SPACING_CONSTANT,
                    children: [
                      Expanded(
                        child: Text(
                          widget.result.albumName,
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
          ],
        ),
      ),
    );
  }
}
