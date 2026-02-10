import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
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
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  primaryColor: Colors.black,
  canvasColor: Colors.grey[900],
  scaffoldBackgroundColor: Colors.grey[800],
  cardColor: Colors.grey[800],
);
