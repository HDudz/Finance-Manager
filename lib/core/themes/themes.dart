import 'package:flutter/material.dart';



ThemeData getDarkTheme(Color color) {
  return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
      seedColor: color,
      brightness: Brightness.dark,
      )
  );
}

ThemeData getLightTheme(Color color) {
  return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: color,
        brightness: Brightness.light,
      )
  );
}