import 'package:flutter/material.dart';

import '../gen/colors.gen.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Barlow',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      fixedSize: const Size.fromHeight(50.0),
      backgroundColor: ColorName.primary,
      foregroundColor: ColorName.onPrimary,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      )
    )
  ),
  dividerColor: ColorName.surface,
  colorScheme: const ColorScheme.dark(
    background: ColorName.background,
    onBackground: ColorName.onBackground,
    surface: ColorName.surface,
    onSurface: ColorName.onSurface,
    primary: ColorName.primary,
    onPrimary: ColorName.onPrimary,
  ),
);