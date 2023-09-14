import 'package:flutter/material.dart';

import '../gen/colors.gen.dart';

class CircleButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;

  const CircleButton({
    super.key,
    required this.child,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  const CircleButton.primary({
    super.key,
    required this.child,
    required this.onPressed,
  })  : backgroundColor = ColorName.primary,
        foregroundColor = ColorName.onPrimary;

  const CircleButton.surface({
    super.key,
    required this.child,
    required this.onPressed,
  })  : backgroundColor = ColorName.surface,
        foregroundColor = ColorName.onSurface;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
