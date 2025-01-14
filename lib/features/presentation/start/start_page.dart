import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/TransactionCard.dart';
import '../../data/app_database.dart';
import '../../provider/config_provider.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {


  late AppDatabase db;
  var transactions;
  var balance;

  loadData() async {
    db = Provider.of<AppDatabase>(context, listen: false);
    final fetchedBalance = await db.getBalance();
    final result = await db.getAllTransactions();
    setState(() {
      transactions = result.sublist(result.length-3, result.length);
      balance = fetchedBalance;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final configProvider = Provider.of<ConfigProvider>(context, listen: false);

    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onSurface,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
          child: Text("Witaj, ${configProvider.username}:", style: style),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: theme.colorScheme.primary, // Kolor konturu
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
                  balance == null ? Center(child: CircularProgressIndicator()):Text(balance.toStringAsFixed(2), style: Theme.of(context).textTheme.displayMedium),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
          child: Container(
              width: double.infinity,
              child: Text(
                  "Ostatnie transakcje:",
                  textAlign: TextAlign.left,
                  style: style.copyWith(fontSize: 25)
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  transactions == null ? Center(child: CircularProgressIndicator()) : Column(
                    children: [
                      for (var transaction in transactions.reversed)
                        TransactionCard(theme: theme, transaction: transaction, expandable: false,),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}