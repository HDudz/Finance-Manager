import 'package:finance_manager/core/ColorsGen.dart';
import 'package:finance_manager/core/themes/themes.dart';
import 'package:finance_manager/features/presentation/home.dart';
import 'package:finance_manager/features/state/app_config.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'features/data/app_database.dart';
import 'features/provider/config_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final config = await AppConfig.loadConfig();

  runApp(MyApp(config: config));
}


class MyApp extends StatelessWidget {
  final AppConfig config;

  const MyApp({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => AppDatabase(),
          dispose: (context, AppDatabase db) => db.close(),
        ),
        ChangeNotifierProvider(
          create: (_) => ConfigProvider(config),
        ),
      ],
      child: Consumer<ConfigProvider>(
        builder: (context, configProvider, _) {
          return MaterialApp(
            title: 'Finance Manager',
            theme: getLightTheme(colorMap[configProvider.selectedColor] ?? Colors.blue),
            darkTheme: getDarkTheme(colorMap[configProvider.selectedColor] ?? Colors.blue),
            themeMode: configProvider.systemTheme
                ? ThemeMode.system
                : (configProvider.darkTheme ? ThemeMode.dark : ThemeMode.light),
            home: MyHomePage(),
          );
        },
      ),
    );
  }
}


