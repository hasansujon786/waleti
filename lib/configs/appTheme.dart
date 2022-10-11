import 'package:flutter/material.dart';

import 'configs.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    primarySwatch: Palette.primary,
    /* visualDensity: VisualDensity.adaptivePlatformDensity, */
    fontFamily: 'rubik',
    appBarTheme: const AppBarTheme(centerTitle: true),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Palette.primary,
      unselectedItemColor: Colors.grey.shade600,
      backgroundColor: Colors.white,
    ),
    // colorScheme: const ColorScheme.light(),
  );
}
