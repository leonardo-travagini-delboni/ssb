import 'package:flutter/material.dart';
import 'package:ssb/config/params.dart';

// Debug print function
void dp(String statement) {
  if (enableDebugPrint) {
    debugPrint('DEBUG - $statement');
  }
}
