import 'package:flutter/material.dart';

class GenderCard extends StatelessWidget {
  final Widget image;
  final String text;
  final bool isSelected;
  final VoidCallback? onPressed;

  const GenderCard({
    super.key,
    required this.image,
    required this.text,
    this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final backgroundColor = isSelected ? colors.primary : colors.surface;
    final foregroundColor = isSelected ? colors.onPrimary : colors.onSurface;

    return AspectRatio(
      aspectRatio: 1.0,
      child: Card(
        color: backgroundColor,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image,
                const SizedBox(height: 8.0),
                Text(
                  text,
                  style: TextStyle(color: foregroundColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
