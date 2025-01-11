import 'dart:io';

import 'package:finance_manager/core/themes/themes.dart';
import 'package:finance_manager/features/presentation/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'features/data/app_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        Provider(
          create: (context) => AppDatabase(),
          dispose: (context, AppDatabase db) => db.close(),
        ),
      ],

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








