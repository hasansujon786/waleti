import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWeek extends StatelessWidget {
  const LineChartWeek({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LineChart(
        chartData,
        swapAnimationDuration: const Duration(milliseconds: 250),
      ),
    );
  }

  LineChartData get chartData => LineChartData(
        lineTouchData: LineTouchData(enabled: false),
        gridData: FlGridData(show: false),
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: [
          barData,
        ],
        minX: 0,
        maxX: 12,
        maxY: 7,
        minY: 0,
      );

  LineChartBarData get barData => LineChartBarData(
        isCurved: false,
        color: const Color(0x99aa4cfc),
        barWidth: 4,
        isStrokeCapRound: false,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(
          show: true,
          gradient: const LinearGradient(
            colors: [
              Color(0x83aa4cfc),
              Color(0x00aa4cfc),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        spots: const [
          FlSpot(-20, 9),
          FlSpot(0, 3),
          FlSpot(2, 2.8),
          FlSpot(4, 1.2),
          FlSpot(6, 2.8),
          FlSpot(8, 2.6),
          FlSpot(10, 3.9),
          FlSpot(12, 3),
          FlSpot(20, 3),
        ],
      );

  // decorations
  FlBorderData get borderData => FlBorderData(
        show: false,
        border: const Border(
          bottom: BorderSide(color: Color(0x404e4965), width: 1),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff72719b),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'S';
        break;
      case 2:
        text = 'M';
        break;
      case 4:
        text = 'T';
        break;
      case 6:
        text = 'W';
        break;
      case 8:
        text = 'T';
        break;
      case 10:
        text = 'F';
        break;
      case 12:
        text = 'S';
        break;
      default:
        text = '';
        break;
    }

    return SideTitleWidget(axisSide: meta.axisSide, child: Text(text, style: style));
  }
}

class LineChartContainer extends StatefulWidget {
  const LineChartContainer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LineChartContainerState();
}

class LineChartContainerState extends State<LineChartContainer> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5, // 3/2
      child: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Color(0xff2c274c),
        //       Color(0xff46426c),
        //     ],
        //     begin: Alignment.bottomCenter,
        //     end: Alignment.topCenter,
        //   ),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const <Widget>[
            Expanded(child: LineChartWeek()),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
