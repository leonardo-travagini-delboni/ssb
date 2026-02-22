import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssb/config/func.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('themeMode') ?? 'system';
    _themeMode = _stringToThemeMode(themeString);
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    dp('Setting theme mode to: $mode');
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    String newThemeMode = mode.toString().split('.').last.trim();
    dp('Saving theme mode to preferences: <<$newThemeMode>>');
    await prefs.setString('themeMode', newThemeMode);
  }

  ThemeMode _stringToThemeMode(String themeString) {
    switch (themeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
