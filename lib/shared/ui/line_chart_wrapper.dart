import 'package:flutter/material.dart';

import '../../models/models.dart';
import 'ui.dart';

class LineChartWrapper extends StatefulWidget {
  final List<ChartBarItemDataOfDay> weeklyTransactionsData;
  const LineChartWrapper({
    Key? key,
    required this.weeklyTransactionsData,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => LineChartWrapperState();
}

class LineChartWrapperState extends State<LineChartWrapper> {
  var _currentDayViewIndex = 6;

  void updateCurrentDayViewIndex(int index) {
    setState(() {
      _currentDayViewIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5, // 3/2
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 8),
            const BillBoard(),
            const SizedBox(height: 8),
            Expanded(
              child: LineChartWeek(
                currentDayViewIndex: _currentDayViewIndex,
                onUpdateViewIndex: updateCurrentDayViewIndex,
                weeklyTransactionsData: widget.weeklyTransactionsData,
              ),
            ),
            const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}

// purple gradient
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

