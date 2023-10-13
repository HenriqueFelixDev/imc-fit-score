import 'package:flutter/material.dart';
import 'package:imc_fitscore/gen/colors.gen.dart';

class AppSnackbar extends SnackBar {
  AppSnackbar({
    super.key,
    IconData? icon,
    required String text,
  }) : super(
          backgroundColor: ColorName.surface,
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              if (icon != null) Icon(icon),
              if (icon != null) const SizedBox(width: 4.0),
              Text(text, style: const TextStyle(color: ColorName.onSurface)),
            ],
          ),
        );
}
