import 'package:flutter/cupertino.dart';

// ANCHOR Button
class Button extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  // ANCHOR Constructor
  const Button({
    super.key,
    required this.icon,
    required this.onPressed,
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
        8,
      ),
      onPressed: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8F9),
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        child: Center(
          child: Container(
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 23,
            ),
          ),
        ),
      ),
    );
  }
}
