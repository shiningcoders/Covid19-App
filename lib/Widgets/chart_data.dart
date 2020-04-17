import 'package:charts_flutter/flutter.dart' as charts;

class ChartData {
  final String name;
  final int amount;
  charts.Color barColor;

  ChartData({
  	this.name,
	this.amount,
	this.barColor,
  });
}
