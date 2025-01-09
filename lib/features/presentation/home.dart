
import 'package:finance_manager/features/presentation/start_page.dart';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'transactions_pages/nav.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    WakelockPlus.toggle(enable: true);
    print("Wake on");
  }


  @override
  void dispose() {
    WakelockPlus.disable();

    print("Wake off");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = StartPage();
      case 1:
        page = TransNavigation();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            bottomNavigationBar: NavigationBar(
                destinations: [
                  NavigationDestination(icon: Icon(Icons.home), label: "Home"),
                  NavigationDestination(icon: Icon(Icons.monitor_heart), label: "Fav")
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                }
            ),
            body: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),


          );
        }
    );
  }
}