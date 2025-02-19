import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jurham/utils/helper.dart';

class AraArbChart extends StatelessWidget {
  const AraArbChart({super.key, required this.results});

  final Map<String, dynamic> results;
  @override
  Widget build(BuildContext context) {
    List<FlSpot> araSpots = results['araValues'].map<FlSpot>((item) {
      return FlSpot(item['no'].toDouble() + 1, item['ara'].toDouble());
    }).toList();

    List<FlSpot> arbSpots = results['arbValues'].map<FlSpot>((item) {
      return FlSpot(item['no'].toDouble() + 1, item['arb'].toDouble());
    }).toList();

    araSpots.insert(0, FlSpot(1, results['hargaPenutupan'].toDouble()));
    arbSpots.insert(0, FlSpot(1, results['hargaPenutupan'].toDouble()));

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        maxY: calculateRoundedMaxY(
          araSpots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: araSpots,
            isCurved: false,
            color: Colors.green,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
          ),
          LineChartBarData(
            spots: arbSpots,
            isCurved: false,
            color: Colors.red,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
          ),
          LineChartBarData(
            spots: [
              FlSpot(1, results['hargaPenutupan'].toDouble()),
            ],
            isCurved: false,
            color: Colors.grey,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
