import 'package:flutter/cupertino.dart';

// ANCHOR Button Block
class ButtonBlock extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  // ANCHOR Constructor
  const ButtonBlock({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return CupertinoButton(
      color: CupertinoTheme.of(context).primaryColor,
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 0,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          Icon(
            icon,
            size: 24,
            color: CupertinoColors.white,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.white,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
