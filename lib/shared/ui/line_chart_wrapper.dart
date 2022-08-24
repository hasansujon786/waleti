import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/models.dart';
import '../../extensions/date_time_extension.dart';
import 'ui.dart';

class LineChartWrapper extends StatefulWidget {
  final List<MyTransaction> userTransactions;
  const LineChartWrapper({
    Key? key,
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
    _currentDayViewIndex = todayNameIndex;
  }

  void updateCurrentDayViewIndex(int index) {
    setState(() {
      _currentDayViewIndex = index;
    });
  }

  List<MyTransaction> get thisWeekTransactions {
    return widget.userTransactions
        .where((tx) => tx.createdAt.isAfter(DateTime.now().subtract(Duration(days: todayNameIndex + 1))))
        .toList();
  }

  double get totalSpendingOfWeek {
    return thisWeekTransactions.fold(0, (sum, item) => sum + item.amount);
  }

  DateTime get today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  int get todayNameIndex {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final dayName = DateFormat.E().format(DateTime.now());
    return days.indexWhere((element) => element == dayName);
  }

  List<ChartBarItemDataOfDay> get groupedTransactionValues {
    final tileWidth = (MediaQuery.of(context).size.width - 8) / 7;
    final rightSideIndex = 6 - todayNameIndex;
    final now = DateTime.now();

    return List.generate(
      7,
      (index) {
        final dateToCheck = now.subtract(Duration(days: index - rightSideIndex));
        double totalsum = 0.0;

        for (var i = 0; i < thisWeekTransactions.length; i++) {
          if (thisWeekTransactions[i].createdAt.isSameDayAs(dateToCheck)) {
            totalsum += thisWeekTransactions[i].amount;
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
            const SizedBox(height: 8),
            BillBoard(
              currentDaySelectedBalance: groupedTransactionValues[_currentDayViewIndex].totalSpendingOfDay,
            ),
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
