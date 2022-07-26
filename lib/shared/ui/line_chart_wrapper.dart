import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../extensions/date_time_extension.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import 'ui.dart';

class LineChartWrapper extends StatelessWidget {
  const LineChartWrapper({
    Key? key,
    required this.currentSelectedDates,
    required this.userTransactions,
  }) : super(key: key);

  final List<DateTime> currentSelectedDates;
  final List<MyTransaction> userTransactions;

  double get totalSpendingOfWeek {
    // TODO: <30.08.22> use from provider
    return userTransactions.fold(0, (sum, item) => sum + item.amount);
  }

  List<ChartBarItemDataOfDay> get groupedTransactionValues {
    return currentSelectedDates.map((dateToCheck) {
      double sumOfDay = 0.0;

      for (var i = 0; i < userTransactions.length; i++) {
        if (userTransactions[i].createdAt.isSameDayAs(dateToCheck)) {
          sumOfDay += userTransactions[i].amount;
        }
      }

      final percentage = sumOfDay / totalSpendingOfWeek;
      return ChartBarItemDataOfDay(
        dateTime: dateToCheck,
        isToday: dateToCheck.isToday,
        totalSpendingOfDay: sumOfDay,
        spendignPercentage: percentage > 0 ? percentage : 0,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final tileWidth = (MediaQuery.of(context).size.width - 8) / 7;

    return AspectRatio(
      aspectRatio: 1.5, // 3/2
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const BillBoard(),
            const SizedBox(height: 8),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) => LineChartWeek(
                  tileWidth: tileWidth,
                  selectedDay: ref.watch(currentSelectedDayProvider),
                  onUpdateViewIndex: (idx, selectedDate) {
                    ref.read(currentSelectedDayProvider.state).state = selectedDate;
                  },
                  weeklyTransactionsData: groupedTransactionValues,
                ),
              ),
            ),
            const SizedBox(height: 10),
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
