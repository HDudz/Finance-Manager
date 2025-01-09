import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    db = Provider.of<AppDatabase>(context, listen: false);
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    final result = await db.getAllTransactions(); // Pobranie danych z bazy
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



    if (transactions == null) {
      return Center(child: CircularProgressIndicator()); // Ładowanie danych
    }


    return Column(
      children: [
        Expanded(
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text("Historia transakcji:", style: style),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      for (var transaction in transactions)
                        Card(
                          child: ListTile(
                            title: Text(transaction),
                            onTap: () {

                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
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
              onPressed:() => widget.switchPage(1),
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