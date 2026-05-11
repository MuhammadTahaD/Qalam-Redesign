// File: lib/core/config/app_config.dart
// Purpose: Configuration file providing API base URL based on platform (web/mobile).

import 'package:flutter/foundation.dart';

class AppConfig {
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:5000/api';
    }
    return 'http://10.0.2.2:5000/api';
  }
}
