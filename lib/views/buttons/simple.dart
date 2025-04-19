import 'package:flutter/cupertino.dart';

// ANCHOR Button Simple
class ButtonSimple extends StatelessWidget {
  final double borderRadius;
  final Alignment alignment;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Widget child;

  // ANCHOR Constructor
  const ButtonSimple({
    super.key,
    this.borderRadius = 0,
    this.alignment = Alignment.center,
    this.onPressed,
    this.onLongPress,
    required this.child,
  });

  // ANCHOR Build
  @override
  Widget build(
    BuildContext context,
  ) {
    return CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(
        borderRadius,
      ),
      alignment: alignment,
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: child,
    );
  }
}
