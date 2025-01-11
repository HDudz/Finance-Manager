import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/app_database.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {


  late AppDatabase db;
  var balance;

  loadBalance() async {
    db = Provider.of<AppDatabase>(context, listen: false);
    final fetchedBalance = await db.getBalance();

    setState(() {
      balance = fetchedBalance;
    });
  }

  @override
  void initState() {
    super.initState();
    loadBalance();
  }

  @override
  Widget build(BuildContext context) {

    IconData icon;




    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(

            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.blue, // Kolor konturu
                width: 3.0, // Grubość konturu
              ),
              borderRadius: BorderRadius.circular(15.0), // Zaokrąglenie rogów (opcjonalne)
            ),
            child: Container(
              width: double.infinity, // Rozciąga Card na całą szerokość
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bilans:", style: Theme.of(context).textTheme.displayMedium),
                  balance == null ? Center(child: CircularProgressIndicator()):Text(balance.toString(), style: Theme.of(context).textTheme.displayMedium),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}