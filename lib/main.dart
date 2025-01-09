import 'package:finance_manager/core/themes/themes.dart';
import 'package:finance_manager/features/presentation/home.dart';
import 'package:finance_manager/features/state/MyAppState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Finance Manager',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: MyHomePage(),
      ),
    );
  }
}








