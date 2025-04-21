import 'package:flutter/cupertino.dart';

// ANCHOR Button Block
class ButtonBlock extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  // ANCHOR Constructor
  const ButtonBlock({
    super.key,
    required this.text,
    required this.onPressed,
  });

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return CupertinoButton(
      color: CupertinoTheme.of(context).primaryColor,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15.5,
          fontWeight: FontWeight.w500,
          color: CupertinoColors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
