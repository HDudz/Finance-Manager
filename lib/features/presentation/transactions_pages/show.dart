import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/TransactionCard.dart';
import '../../data/app_database.dart';

class ShowTransPage extends StatefulWidget{
  final switchPage;

  const ShowTransPage({super.key, required this.switchPage});

  @override
  State<ShowTransPage> createState() => _ShowTransPageState();
}

class _ShowTransPageState extends State<ShowTransPage> {
  var transactions;
  late AppDatabase db;


  @override
  void initState() {
    super.initState();

    loadTransactions();
  }

  Future<void> loadTransactions() async {
    db = Provider.of<AppDatabase>(context, listen: false);
    final result = await db.getAllTransactions();
    setState(() {
      transactions = result;
    });
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onSurface,
    );




    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
          child: Text("Historia transakcji:", style: style),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                     Expanded(
                      child: transactions == null ? Center(child: CircularProgressIndicator()) : ListView(
                        children: [
                          for (var transaction in transactions.reversed)
                            TransactionCard(theme: theme, transaction: transaction),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.green.shade800),
              ),
              onPressed:() => widget.switchPage(2),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("Dodaj Transakcję",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

