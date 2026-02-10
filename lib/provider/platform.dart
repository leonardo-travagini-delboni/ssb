import 'dart:io' if (dart.library.io) 'dart:io' as io;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class PlatformProvider extends ChangeNotifier {
  bool _isWeb = false;
  bool _isAndroid = false;
  bool _isIOS = false;
  bool _isWindows = false;
  bool _isLinux = false;
  bool _isMacOS = false;
  bool _isFuchsia = false;
  String _platform = '';

  bool get isWeb => _isWeb;
  bool get isAndroid => _isAndroid;
  bool get isIOS => _isIOS;
  bool get isWindows => _isWindows;
  bool get isLinux => _isLinux;
  bool get isMacOS => _isMacOS;
  bool get isFuchsia => _isFuchsia;
  String get platform => _platform;

  PlatformProvider();

  void setPlatform() {
    if (kIsWeb) {
      _isWeb = true;
      _platform = 'Web';
    } else {
      _isAndroid = io.Platform.isAndroid;
      _isIOS = io.Platform.isIOS;
      _isWindows = io.Platform.isWindows;
      _isLinux = io.Platform.isLinux;
      _isMacOS = io.Platform.isMacOS;
      _isFuchsia = io.Platform.isFuchsia;
      if (_isAndroid) {
        _platform = 'Android';
      } else if (_isIOS) {
        _platform = 'iOS';
      } else if (_isWindows) {
        _platform = 'Windows';
      } else if (_isLinux) {
        _platform = 'Linux';
      } else if (_isMacOS) {
        _platform = 'macOS';
      } else if (_isFuchsia) {
        _platform = 'Fuchsia';
      } else {
        _platform = 'Unknown';
      }
    }
    notifyListeners();
  }
}
