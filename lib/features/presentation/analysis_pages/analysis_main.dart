import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
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
  var colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.deepPurple,
    Colors.green,
    Colors.orangeAccent,
    Colors.teal,
    Colors.lightGreenAccent.shade700,
    Colors.pink
  ];
  var colorSeed = Random().nextInt(10);



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


  double countByCat(String category){
    var count = 0.0;

    for (var transaction in transactions) {
      if(transaction.category == category && transaction.type == "Wychodzące")
        {
          count++;
        }
    }

    return count;
  }

  double sumSpentBtCat(String category){
    var sum = 0.0;

    for (var transaction in transactions) {
      if(transaction.category == category && transaction.type == "Wychodzące")
      {
        sum+=transaction.amount;
      }
    }

    return sum;
  }


  Color getColor(category)
  {
    return colorList[categories.indexOf(category)+colorSeed%colorList.length];
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
                            PieChart(
                              PieChartData(
                                sections: [
                                  for (var category in categories)
                                    PieChartSectionData(value: countByCat(category), radius: 150, title: category, color: getColor(category), titleStyle: style.copyWith(fontSize: 16, color: Colors.black )),
                                ],
                                centerSpaceRadius: 0,
                              )
                            ),
                            PieChart(
                                PieChartData(
                                  sections: [
                                    for (var category in categories)
                                      PieChartSectionData(value: sumSpentBtCat(category), radius: 150, title: category, color: getColor(category), titleStyle: style.copyWith(fontSize: 16, color: Colors.black )),
                                  ],
                                  centerSpaceRadius: 0,
                                )
                            ),
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
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: DefaultTabController(
              length: categories.length,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      for (var category in categories)
                        Tab(text: category),
                    ],
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