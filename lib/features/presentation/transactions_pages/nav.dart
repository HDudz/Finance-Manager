import 'package:finance_manager/features/presentation/transactions_pages/add.dart';
import 'package:finance_manager/features/presentation/transactions_pages/show.dart';
import 'package:flutter/material.dart';





class TransNavigation extends StatefulWidget {
  const TransNavigation({super.key});



  @override
  State<TransNavigation> createState() => _TransNavigationState();
}

class _TransNavigationState extends State<TransNavigation> {

  var selectedIndex = 0;


  void _switchPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = ShowTransPage(switchPage: _switchPage);
      case 1:
        page = AddTransPage(switchPage: _switchPage);
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return SafeArea(
        child: page
    );
  }

}
