import 'package:flutter/material.dart';

final ColorScheme lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 228, 0, 0),
  primary: const Color.fromARGB(255, 222, 28, 28),
);

final ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 228, 0, 0),
  primary: const Color.fromARGB(255, 227, 47, 47),
  brightness: Brightness.dark,
);

class AppTheme {
  static ThemeData getTheme({required ThemeMode themeMode}) {
    return ThemeData(
      colorScheme:
          themeMode == ThemeMode.light ? lightColorScheme : darkColorScheme,
      useMaterial3: true,
    );
  }
}
