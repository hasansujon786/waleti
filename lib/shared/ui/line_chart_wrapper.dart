import 'package:flutter/material.dart';

import '../../extensions/date_time_extension.dart';
import '../../models/models.dart';
import 'ui.dart';

class LineChartWrapper extends StatefulWidget {
  final List<MyTransaction> userTransactions;
  final int todayNameIndex;
  const LineChartWrapper({
    Key? key,
    this.todayNameIndex = 0,
    required this.userTransactions,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => LineChartWrapperState();
}

class LineChartWrapperState extends State<LineChartWrapper> {
  var _currentDayViewIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentDayViewIndex = widget.todayNameIndex;
  }

  void updateCurrentDayViewIndex(int index) {
    setState(() {
      _currentDayViewIndex = index;
    });
  }

  double get totalSpendingOfWeek {
    return widget.userTransactions.fold(0, (sum, item) => sum + item.amount);
  }

  List<ChartBarItemDataOfDay> get groupedTransactionValues {
    final tileWidth = (MediaQuery.of(context).size.width - 8) / 7;
    final rightSideIndex = 6 - widget.todayNameIndex;
    final now = DateTime.now();

    return List.generate(
      7,
      (index) {
        final dateToCheck = now.subtract(Duration(days: index - rightSideIndex));
        double totalsum = 0.0;

        for (var i = 0; i < widget.userTransactions.length; i++) {
          if (widget.userTransactions[i].createdAt.isSameDayAs(dateToCheck)) {
            totalsum += widget.userTransactions[i].amount;
          }
        }

        return ChartBarItemDataOfDay(
          width: tileWidth,
          dateTime: dateToCheck,
          isToday: dateToCheck.isToday,
          totalSpendingOfDay: totalsum,
          spendignPercentace: totalsum / totalSpendingOfWeek,
        );
      },
    ).reversed.toList();
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
            BillBoard(currentDaySelectedBalance: groupedTransactionValues[_currentDayViewIndex].totalSpendingOfDay),
            const SizedBox(height: 8),
            Expanded(
              child: widget.userTransactions.isEmpty
                  // if empty
                  ? const SizedBox()
                  : LineChartWeek(
                      currentDayViewIndex: _currentDayViewIndex,
                      onUpdateViewIndex: updateCurrentDayViewIndex,
                      weeklyTransactionsData: groupedTransactionValues,
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
