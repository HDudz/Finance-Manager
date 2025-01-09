import 'package:flutter/material.dart';

var darkTheme = ThemeData(
useMaterial3: true,
colorScheme: ColorScheme.fromSeed(
seedColor: Colors.blueAccent,
brightness: Brightness.dark,
));

var lightTheme = ThemeData(
useMaterial3: true,
colorScheme: ColorScheme.fromSeed(
seedColor: Colors.blueAccent,
brightness: Brightness.light,
));