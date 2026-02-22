import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  primaryColor: Colors.blue,
  canvasColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.grey[100],
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1F1F1F),
    foregroundColor: Colors.white,
  ),
  primaryColor: Colors.blueGrey[900],
  canvasColor: Colors.grey[900],
  scaffoldBackgroundColor: const Color(0xFF121212),
  cardColor: const Color(0xFF1E1E1E),
);
