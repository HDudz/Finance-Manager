import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyBarChart extends StatefulWidget {
  final List transactions;
  final int choice;

  const MyBarChart({
    super.key,
    required this.choice,
    required this.transactions,
  });

  @override
  State<MyBarChart> createState() => _MyBarChartState();
}

class _MyBarChartState extends State<MyBarChart> {
  List<BarChartGroupData> _prepareChartData() {
    Map<String, int> dataCount = {};

    final now = DateTime.now();

    if (widget.choice == 0) {
      for (int i = 0; i < 7; i++) {
        final dateKey = DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: i)));
        dataCount[dateKey] = 0;
      }

      for (var transaction in widget.transactions) {
        final transactionDate = DateTime.parse(transaction.date.toString());
        final dateKey = DateFormat('yyyy-MM-dd').format(transactionDate);
        if (dataCount.containsKey(dateKey)) {
          dataCount[dateKey] = (dataCount[dateKey] ?? 0) + 1;
        }
      }
    } else if (widget.choice == 1) {
      for (int i = 0; i < 30; i++) {
        final dateKey = DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: i)));
        dataCount[dateKey] = 0;
      }

      for (var transaction in widget.transactions) {
        final transactionDate = DateTime.parse(transaction.date.toString());
        final dateKey = DateFormat('yyyy-MM-dd').format(transactionDate);
        if (dataCount.containsKey(dateKey)) {
          dataCount[dateKey] = (dataCount[dateKey] ?? 0) + 1;
        }
      }
    } else if (widget.choice == 2) {
      // Ostatni rok - podział na miesiące
      for (int i = 0; i < 12; i++) {
        final dateKey = DateFormat('yyyy-MM').format(DateTime(now.year, now.month - i, 1));
        dataCount[dateKey] = 0;
      }

      for (var transaction in widget.transactions) {
        final transactionDate = DateTime.parse(transaction.date.toString());
        final dateKey = DateFormat('yyyy-MM').format(transactionDate);
        if (dataCount.containsKey(dateKey)) {
          dataCount[dateKey] = (dataCount[dateKey] ?? 0) + 1;
        }
      }
    }
    // Tworzenie danych dla BarChart
    List<BarChartGroupData> barGroups = [];
    int index = 0;
    dataCount.entries.toList().reversed.forEach((entry) {
      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: entry.value.toDouble(),
              color: Colors.blue,
              width: 13,
              borderRadius: BorderRadius.circular(4),

            ),
          ],
        ),
      );
      index++;
    });

    return barGroups;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);


    final barGroups = _prepareChartData();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            barGroups: barGroups,
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: true, horizontalInterval: 1, drawVerticalLine: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 20,
                  getTitlesWidget: (value, meta) {
                    return Text(value.toInt().toString(), style: TextStyle(fontSize: 12));
                  },
                  interval: 1
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 20,
                  getTitlesWidget: (value, meta) {
                    if (value.toInt() >= 0 && value.toInt() < barGroups.length) {
                      if (widget.choice == 2) {
                        return Text(
                          DateFormat('MMM').format(DateTime.now().subtract(Duration(days: 30*11)).add(Duration(days: 30 * value.toInt()))),
                          style: TextStyle(fontSize: 10),
                        );
                      }
                      else if (widget.choice == 1 && value % 7 == 0) {
                        return Transform.rotate(
                          angle: 0,
                          child: Text(
                            DateFormat('dd.MM').format(DateTime.now().subtract(Duration(days: 29)).add(Duration(days: value.toInt()))),
                            style: TextStyle(fontSize: 10),
                          ),
                        );
                      }
                      else if(widget.choice == 0) {
                        return Text(
                        DateFormat('dd.MM').format(DateTime.now().subtract(Duration(days: 6)).add(Duration(days: value.toInt()))),
                        style: TextStyle(fontSize: 10),
                        );
                      }
                    }
                    return Text('');
                  },
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                )
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                )
              )
            ),
          )
      ),
    );
  }
}
