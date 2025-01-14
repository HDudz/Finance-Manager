import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AppConfig {

  String username;
  bool darkTheme;
  bool systemTheme;
  String selectedColor;



  AppConfig({
    required this.username,
    required this.darkTheme,
    required this.systemTheme,
    required this.selectedColor,
  });

  static Future<AppConfig> loadConfig() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/config.json');

    if (await file.exists()) {
      final content = await file.readAsString();
      final data = jsonDecode(content);

      return AppConfig(
        username: data['username'] ?? 'Użytkowniku',
        darkTheme: data['darkTheme'] ?? true,
        systemTheme: data['systemTheme'] ?? true,
        selectedColor: data['selectedColor'] ?? 'Niebieski',
      );
    } else {
      // Create a default configuration if the file doesn't exist
      final defaultConfig = AppConfig(
        username: 'Użytkowniku',
        darkTheme: true,
        systemTheme: true,
        selectedColor: 'Niebieski',
      );
      await file.writeAsString(jsonEncode({
        'username': defaultConfig.username,
        'darkTheme': defaultConfig.darkTheme,
        'systemTheme': defaultConfig.systemTheme,
        'selectedColor': defaultConfig.selectedColor,
      }));
      return defaultConfig;
    }
  }

  Future<void> saveConfig() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/config.json');

    await file.writeAsString(jsonEncode({
      'username': username,
      'darkTheme': darkTheme,
      'systemTheme': systemTheme,
      'selectedColor': selectedColor,
    }));
  }
}