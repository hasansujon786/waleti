import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    primarySwatch: Colors.deepPurple,
    /* visualDensity: VisualDensity.adaptivePlatformDensity, */
    fontFamily: 'rubik',
    appBarTheme: const AppBarTheme(centerTitle: true),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey.shade600,
      backgroundColor: Colors.white,
    ),
    // colorScheme: const ColorScheme.light(),
  );
}
