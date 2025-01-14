import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../ColorsGen.dart';


class MyPieChart extends StatefulWidget {
  final labels, values;

  const MyPieChart({
    super.key,
    required this.labels,
    required this.values
  });

  @override
  State<MyPieChart> createState() => _MyPieChartState();
}


class _MyPieChartState extends State<MyPieChart> {




  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onSurface,
    );
    var counter = 0;

    return PieChart(
        PieChartData(
          sections: [
            for (var item in widget.labels)
              PieChartSectionData(
                  radius: 150,
                  value: widget.values[counter],
                  title: item + "\n" + widget.values[counter++].toString(),
                  color: getColor(widget.labels, item),
                  titleStyle: style.copyWith(fontSize: 16, color: Colors.black ),
                   titlePositionPercentageOffset: 0.6,
              ),
          ],
          centerSpaceRadius: 0,
        )
    );
  }
}




