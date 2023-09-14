import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Barlow',
  colorScheme: const ColorScheme.dark(
    background: Color(0xFF1E1E1E),
    onBackground: Color(0xFFE0E0E0),
    surface: Color(0xFF333333),
    onSurface: Color(0xFFE0E0E0),
    primary: Color(0xFFFF8845),
    onPrimary: Color(0xFF161616),
  ),
);