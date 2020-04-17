import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'chart_data.dart';

class BarChart extends StatelessWidget {
  final List<ChartData> data;

  BarChart({ this.data });

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ChartData, String>> series = [
      charts.Series(
        id: "Data",
        data: data,
        domainFn: (ChartData series, _) => series.name,
        measureFn: (ChartData series, _) => series.amount,
        colorFn: (ChartData series, _) => series.barColor,
      )
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(20),
      child: Card(
        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
        color: Color(0xFFF2F2FA),
        elevation: 0.0,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: charts.BarChart(series, animate: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
