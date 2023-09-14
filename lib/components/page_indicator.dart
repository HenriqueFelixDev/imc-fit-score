import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final bool isActive;
  const PageIndicator({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final color = isActive ? colors.primary : colors.surface;
    final size = isActive ? 14.0 : 12.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: size,
      height: size,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
