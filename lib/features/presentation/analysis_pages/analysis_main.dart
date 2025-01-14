
import 'package:finance_manager/core/widgets/MyBarChart.dart';
import 'package:finance_manager/core/widgets/MyPieChart.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/app_database.dart';

class AnalysisMainPage extends StatefulWidget{
  final switchPage;

  const AnalysisMainPage({super.key, required this.switchPage});

  @override
  State<AnalysisMainPage> createState() => _AnalysisMainPageState();
}

class _AnalysisMainPageState extends State<AnalysisMainPage> {
  var transactions;
  var categories;
  var choice = "Transakcje";
  late AppDatabase db;





  @override
  void initState() {
    super.initState();
    db = Provider.of<AppDatabase>(context, listen: false);
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    final result = await db.getAllTransactions();
    final catResult = await db.getCategories();
    setState(() {
      transactions = result;
      categories = catResult;
      categories.reversed;
    });
  }


  List<double> countByCat(){

    List<double> counter = [];
    for(var category in categories) {
      var count = 0.0;
      for (var transaction in transactions) {
        if (transaction.category == category &&
            transaction.type == "Wychodzące") {
          count++;
        }
      }
      counter.add(count);
    }

    return counter;
  }

  List<double> sumSpentByCat(){

    List<double> sums = [];
    for(var category in categories){
      var sum = 0.0;
      for (var transaction in transactions) {
        if (transaction.category == category &&
            transaction.type == "Wychodzące") {
          sum += transaction.amount;
        }
      }
      sums.add(sum);
    }

    return sums;
  }




  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onSurface,
    );



    return categories == null ? Center(child: CircularProgressIndicator()) : ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0).copyWith(bottom: 0.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Udział kategorii wydatków ze względu na:", style: style.copyWith(fontSize: 24), textAlign: TextAlign.center,),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0).copyWith(top: 0.0),
          child: Card(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: "Transakcje"),
                      Tab(text: "Kwotę",),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: TabBarView(
                          children: [
                            MyPieChart(labels :categories, values:  countByCat()),
                            MyPieChart(labels :categories, values:  sumSpentByCat()),
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0).copyWith(bottom: 0.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Liczba transakcji przez ostatni:", style: style.copyWith(fontSize: 24), textAlign: TextAlign.center,),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0).copyWith(top: 0.0),
          child: Card(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: "Tydzień"),
                      Tab(text: "Miesiąc",),
                      Tab(text: "Rok"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: TabBarView(
                          children: [
                              MyBarChart(choice: 0, transactions: transactions),
                              MyBarChart(choice: 1, transactions: transactions),
                              MyBarChart(choice: 2, transactions: transactions),
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]
    );
  }
}