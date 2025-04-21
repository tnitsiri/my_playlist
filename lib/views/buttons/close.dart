import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:my_playlist/views/buttons/button.dart';

// ANCHOR Button Close
class ButtonClose extends StatelessWidget {
  // ANCHOR Constructor
  const ButtonClose({
    super.key,
  });

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return Button(
      icon: Ionicons.close,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
