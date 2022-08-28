import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/controllers.dart';
import '../../extensions/date_time_extension.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../shared/utils/utisls.dart';
import 'ui.dart';

class LineChartWrapper extends StatefulWidget {
  const LineChartWrapper({
    Key? key,
    required this.currentSelectedDates,
    required this.userTransactions,
  }) : super(key: key);

  final List<DateTime> currentSelectedDates;
  final List<MyTransaction> userTransactions;

  @override
  State<StatefulWidget> createState() => LineChartWrapperState();
}

class LineChartWrapperState extends State<LineChartWrapper> {
  var _currentDayTransactionIdx = 0;

  @override
  void initState() {
    super.initState();
    _currentDayTransactionIdx = weekIndex(DateTime.now());
  }

  double get totalSpendingOfWeek {
    return widget.userTransactions.fold(0, (sum, item) => sum + item.amount);
  }

  List<ChartBarItemDataOfDay> get groupedTransactionValues {
    final tileWidth = (MediaQuery.of(context).size.width - 8) / 7;

    return widget.currentSelectedDates.map((dateToCheck) {
      double sumOfDay = 0.0;

      for (var i = 0; i < widget.userTransactions.length; i++) {
        if (widget.userTransactions[i].createdAt.isSameDayAs(dateToCheck)) {
          sumOfDay += widget.userTransactions[i].amount;
        }
      }

      final percentage = sumOfDay / totalSpendingOfWeek;
      return ChartBarItemDataOfDay(
        width: tileWidth,
        dateTime: dateToCheck,
        isToday: dateToCheck.isToday,
        totalSpendingOfDay: sumOfDay,
        spendignPercentage: percentage > 0 ? percentage : 0,
      );
    }).toList();
  }

  void changeWeekBydiraction(bool isNext, WidgetRef ref, List<DateTime> currentWeek) {
    if (isNext) {
      ref.read(weekViewControllerProvider.notifier).getNextWeek(currentWeek);
    } else {
      ref.read(weekViewControllerProvider.notifier).getPreviousWeek(currentWeek);
    }
  }

  void updateCurrentDateIdx(int index, DateTime selecTedDate, ref) {
    ref.read(currentSelectedDayProvider.state).state = selecTedDate;
    setState(() {
      _currentDayTransactionIdx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5, // 3/2
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            BillBoard(currentDaySelectedBalance: groupedTransactionValues[_currentDayTransactionIdx].totalSpendingOfDay),
            const SizedBox(height: 8),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) => Stack(
                  children: [
                    LineChartWeek(
                      currentDayViewIndex: _currentDayTransactionIdx,
                      onUpdateViewIndex: (idx, selectedDate) => updateCurrentDateIdx(idx, selectedDate, ref),
                      weeklyTransactionsData: groupedTransactionValues,
                    ),
                    viewControls(ref),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Align viewControls(WidgetRef ref) {
    final curWeek = ref.watch(weekViewControllerProvider);
    return Align(
      alignment: Alignment.topRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => changeWeekBydiraction(false, ref, curWeek),
            icon: const Icon(Icons.chevron_left),
          ),
          IconButton(
            onPressed: () {
              ref.read(weekViewControllerProvider.notifier).getThisWeek();
              final idx = weekIndex(DateTime.now());
              setState(() {
                _currentDayTransactionIdx = idx;
              });
            },
            icon: const Icon(Icons.calendar_today),
          ),
          IconButton(
            onPressed: () => changeWeekBydiraction(true, ref, curWeek),
            icon: const Icon(Icons.chevron_right),
          )
        ],
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
