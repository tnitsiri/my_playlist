import 'package:flutter/cupertino.dart';
import 'package:iconly/iconly.dart';
import 'package:my_playlist/views/buttons/button.dart';

// ANCHOR Back Button
class BackButton extends StatelessWidget {
  // ANCHOR Constructor
  const BackButton({
    super.key,
  });

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return Button(
      icon: IconlyLight.arrow_left,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
