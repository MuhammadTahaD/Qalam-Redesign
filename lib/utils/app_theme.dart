import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF004879);
  static const secondary = Color(0xFF023354);
  static const background = Color(0xFFF8FAFC);
  static const white = Colors.white;
  static const black = Colors.black;
  static const grey = Color(0xFF6B7280);
  static const danger = Colors.red;
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Roboto',
    primaryColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.secondary,
      elevation: 0,
    ),
  );
}
