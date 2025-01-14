
import 'package:flutter/cupertino.dart';

import '../state/app_config.dart';

class ConfigProvider with ChangeNotifier {
  AppConfig _config;

  ConfigProvider(this._config);

  String get username => _config.username;
  bool get darkTheme => _config.darkTheme;
  bool get systemTheme => _config.systemTheme;
  String get selectedColor => _config.selectedColor;

  void updateUsername(String username) {
    _config.username = username;
    _saveConfig();
  }

  void updateTheme({required bool darkTheme, required bool systemTheme}) {
    _config.darkTheme = darkTheme;
    _config.systemTheme = systemTheme;
    _saveConfig();
  }

  void updateSelectedColor(String color) {
    _config.selectedColor = color;
    _saveConfig();
  }

  Future<void> _saveConfig() async {
    await _config.saveConfig();
    notifyListeners();
  }
}