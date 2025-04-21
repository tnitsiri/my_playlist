import 'package:flutter/cupertino.dart';
import 'package:iconly/iconly.dart';

// ANCHOR Image Default
class ImageDefault extends StatelessWidget {
  // ANCHOR Constructor
  const ImageDefault({
    super.key,
  });

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return Center(
      child: Icon(
        IconlyLight.image,
        size: 30,
        color: CupertinoColors.systemGrey4,
      ),
    );
  }
}
