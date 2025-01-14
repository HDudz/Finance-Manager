import 'package:finance_manager/features/presentation/analysis_pages/analysis_main.dart';
import 'package:finance_manager/features/presentation/settings/settings_page.dart';
import 'package:finance_manager/features/presentation/start/start_page.dart';
import 'package:finance_manager/features/presentation/transactions_pages/add.dart';
import 'package:finance_manager/features/presentation/transactions_pages/show.dart';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var pageIndex = 0;
  var choice = 0;
  var pages = [0, 1, 1, 2, 0];
  var appBarText = "Finance Manager";

  @override
  void initState() {
    super.initState();
    WakelockPlus.toggle(enable: true);
    print("Wake on");;
  }

  @override
  void dispose() {
    WakelockPlus.disable();

    print("Wake off");
    super.dispose();
  }

  void switchPage(int index) {
    setState(() {
      pageIndex = index;
      choice = pages[pageIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (pageIndex) {
      case 0:
        page = StartPage();
        appBarText = "Finance Manager";
      case 1:
        page = ShowTransPage(switchPage: switchPage);
        appBarText = "Transakcje";
      case 2:
        page = AddTransPage(switchPage: switchPage);
      case 3:
        page = AnalysisMainPage(switchPage: switchPage);
        appBarText = "Analiza";
      case 4:
        page = SettingsPage(switchPage: switchPage,);
        appBarText = "Ustawienia";
      default:
        throw UnimplementedError('no widget for $pageIndex');
    }

    return LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            bottomNavigationBar: NavigationBar(
                destinations: [
                  NavigationDestination(icon: Icon(Icons.home), label: "Home"),
                  NavigationDestination(icon: Icon(Icons.compare_arrows, size: 30,), label: "Transakcje"),
                  NavigationDestination(icon: Icon(Icons.analytics), label: "Analiza"),
                ],
                selectedIndex: choice,
                onDestinationSelected: (value) {
                  setState(() {
                    choice = value;
                    pageIndex = pages.indexOf(choice);
                  });
                }
            ),
            body: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
            appBar: AppBar(
              title: Text(appBarText),
              leading: pageIndex == 2 ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => switchPage(1),
              ):null,
              actions: [IconButton(onPressed:() => switchPage(4), icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.onSurface,))],
              centerTitle: true,
            ),


          );
        }
    );
  }
}