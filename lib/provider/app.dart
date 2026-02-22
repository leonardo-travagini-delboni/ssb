import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssb/config/func.dart';

class AppProvider extends ChangeNotifier {
  String _route = '/splash';
  bool _isLoading = false;
  bool _skipIntro = false;
  String _headerTitle = 'Paróquia São Sebastião';

  String get route => _route;
  bool get isLoading => _isLoading;
  bool get skipIntro => _skipIntro;
  String get headerTitle => _headerTitle;

  AppProvider() {
    initAppProvider();
  }

  void initAppProvider() {
    dp('AppProvider: Initializing');
    setRoute('/splash');
    setHeaderTitle('Paróquia São Sebastião');
    _loadSkipIntro();
  }

  void setRoute(String route) {
    dp('AppProvider: Setting route to $route');
    _route = route;
    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    dp('AppProvider: Setting isLoading to $isLoading');
    _isLoading = isLoading;
    notifyListeners();
  }

  void setHeaderTitle(String title) {
    dp('AppProvider: Setting headerTitle to $title');
    _headerTitle = title;
    notifyListeners();
  }

  Future<void> _loadSkipIntro() async {
    final prefs = await SharedPreferences.getInstance();
    final skipIntro = prefs.getBool('skipIntro') ?? false;
    dp('AppProvider: Loaded skipIntro from SharedPreferences: $skipIntro');
    _skipIntro = skipIntro;
    notifyListeners();
  }

  Future<void> setSkipIntro(bool skipIntro) async {
    dp('AppProvider: Setting skipIntro to $skipIntro');
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('skipIntro', skipIntro);
    _skipIntro = skipIntro;
    notifyListeners();
  }

  void clearAll() {
    dp('AppProvider: Clearing all state');
    _route = '/splash';
    _isLoading = false;
    // _skipIntro always persists, do not reset it!
    _headerTitle = 'Paróquia São Sebastião';
    notifyListeners();
  }
}
