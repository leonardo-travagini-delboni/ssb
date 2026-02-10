import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssb/config/theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = lightTheme;

  ThemeData get theme => _theme;

  ThemeProvider() {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;
    _theme = isDark ? darkTheme : lightTheme;
    notifyListeners();
  }

  Future<void> switchTheme() async {
    final isDarkMode = _theme == darkTheme;
    _theme = isDarkMode ? lightTheme : darkTheme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', !isDarkMode);
    notifyListeners();
  }
}
