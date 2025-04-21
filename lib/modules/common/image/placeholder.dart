import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

// ANCHOR Image Placeholder
class ImagePlaceholder extends StatelessWidget {
  final double width;
  final double height;

  // ANCHOR Constructor
  const ImagePlaceholder({
    super.key,
    required this.width,
    required this.height,
  });

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return Shimmer.fromColors(
      baseColor: CupertinoColors.systemGrey6,
      highlightColor: CupertinoColors.systemGrey5,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: CupertinoColors.white,
        ),
      ),
    );
  }
}
