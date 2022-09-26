import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../../models/models.dart';
import '../../shared/utils/formatter.dart';
import '../../extensions/date_time_extension.dart';

class LineChartWeek extends StatelessWidget {
  final List<ChartBarItemDataOfDay> weeklyTransactionsData;
  final void Function(int, DateTime) onUpdateViewIndex;
  final DateTime selectedDay;
  final double tileWidth;
  const LineChartWeek({
    Key? key,
    required this.weeklyTransactionsData,
    required this.onUpdateViewIndex,
    required this.selectedDay,
    required this.tileWidth,
  }) : super(key: key);

  List<double> get xValues => [0, 1, 2, 3, 4, 5, 6];
  List<double> get yValues => weeklyTransactionsData.map((item) => item.spendignPercentage).toList();

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
        lineTouchData: LineTouchData(enabled: true),
        gridData: FlGridData(show: false),
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: [
          barData,
        ],
        minX: 0,
        maxX: 6,
        maxY: 1,
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
        spots: [
          for (var i = 0; i < xValues.length; i++) FlSpot(xValues[i], yValues[i]),
          // FlSpot(0, 1),
          // FlSpot(1, 0.8),
          // FlSpot(2, 0.2),
          // FlSpot(3, 0.8),
          // FlSpot(4, 0.6),
          // FlSpot(5, 0.9),
          // FlSpot(6, 0.3),
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
            interval: 1,
            showTitles: true,
            reservedSize: 78,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final index = value.toInt();
    final info = weeklyTransactionsData[index];
    final selected = selectedDay.isSameDayAs(info.dateTime);

    return SideTitleWidget(
      space: 10,
      axisSide: meta.axisSide,
      child: GestureDetector(
        // chage day view on user tap
        onTap: () => onUpdateViewIndex(index, info.dateTime),
        child: SizedBox(
          width: tileWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Formatters.dayName.format(info.dateTime).toUpperCase(),
                style: TextStyle(
                  color: info.isToday ? Colors.white : Colors.white60,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
              ),
              CircleAvatar(
                backgroundColor: info.isToday ? Color(hexColor('#49228d')) : Colors.transparent,
                radius: 18,
                child: Text(
                  info.dateTime.day.toString(),
                  style: TextStyle(
                    color: info.isToday || selected ? Colors.white : Colors.white60,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ),
              AnimatedScale(
                alignment: Alignment.center,
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 280),
                scale: selected ? 1 : 0,
                child: Container(
                  height: 7,
                  width: 30,
                  decoration: BoxDecoration(
                    color: selected ? Color(hexColor('#4184ff')) : Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
