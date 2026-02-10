import 'package:flutter/material.dart';
import 'package:ssb/config/func.dart';

class AppProvider extends ChangeNotifier {
  String _route = '/splash';
  bool _isLoading = false;
  String _headerTitle = 'Paróquia São Sebastião';

  String get route => _route;
  bool get isLoading => _isLoading;
  String get headerTitle => _headerTitle;

  AppProvider() {
    initAppProvider();
  }

  void initAppProvider() {
    dp('AppProvider: Initializing');
    setRoute('/splash');
    setHeaderTitle('Paróquia São Sebastião');
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

  void clearAll() {
    dp('AppProvider: Clearing all state');
    _route = '/splash';
    _isLoading = false;
    _headerTitle = 'Paróquia São Sebastião';
    notifyListeners();
  }
}
