import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../configs/configs.dart';
import '../../providers/providers.dart';
import '../../models/models.dart';
import '../../shared/utils/formatter.dart';

class LineChartWeek extends StatelessWidget {
  final List<ChartBarItemDataOfDay> weeklyTransactionsData;
  final int currentDayViewIndex;
  final Function(int) onUpdateViewIndex;
  const LineChartWeek({
    Key? key,
    required this.weeklyTransactionsData,
    required this.onUpdateViewIndex,
    this.currentDayViewIndex = 0,
  }) : super(key: key);

  List<double> get xValues => [0, 1, 2, 3, 4, 5, 6];
  List<double> get yValues => weeklyTransactionsData.map((item) => item.spendignPercentace).toList();

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
            reservedSize: 70,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final index = value.toInt();
    final info = weeklyTransactionsData[index];

    return SideTitleWidget(
      space: 10,
      axisSide: meta.axisSide,
      child: Consumer(
        builder: (context, ref, child) => GestureDetector(
          onTap: () {
            // chage day view on user tap
            ref.read(currentSelectedDayProvider.state).state = info.dateTime;
            onUpdateViewIndex(index);
          },
          child: child,
        ),
        child: SizedBox(
          width: info.width,
          child: Column(
            children: [
              Text(
                Formatters.dayName.format(info.dateTime),
                style: const TextStyle(color: Color(0xff72719b), fontWeight: FontWeight.bold, fontSize: 10),
              ),
              const Spacer(),
              CircleAvatar(
                backgroundColor: info.isToday ? Palette.primary.withOpacity(0.6) : Colors.transparent,
                radius: 15,
                child: Text(
                  info.dateTime.day.toString(),
                  style: TextStyle(
                    color: info.isToday ? Colors.white : Palette.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 6.2),
              AnimatedScale(
                alignment: Alignment.center,
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 280),
                scale: currentDayViewIndex == index ? 1 : 0,
                child: Container(
                  height: 7,
                  width: 30,
                  decoration: BoxDecoration(
                    color: currentDayViewIndex == index ? Palette.primary.withOpacity(0.7) : Colors.transparent,
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
