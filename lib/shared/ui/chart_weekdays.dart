import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/models.dart';
import './chart_bar.dart';

// List<Transaction> get lastWeekTransactions {
//   return _userTransactions.where((tx) {
//     return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
//   }).toList();
// }
class ChartWeekdays extends StatelessWidget {
  const ChartWeekdays({Key? key, required this.lastWeekTransactions}) : super(key: key);
  final List<MyTransaction> lastWeekTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalsum = 0.0;
        for (var i = 0; i < lastWeekTransactions.length; i++) {
          if (lastWeekTransactions[i].createdAt.day == weekDay.day &&
              lastWeekTransactions[i].createdAt.month == weekDay.month &&
              lastWeekTransactions[i].createdAt.year == weekDay.year) {
            totalsum += lastWeekTransactions[i].amount;
          }
        }

        return {'day': DateFormat.E().format(weekDay), 'totalSpendingOfDay': totalsum};
      },
    ).reversed.toList();
  }

  double get totalSpendingOfWeek {
    return lastWeekTransactions.fold(0, (sum, item) => sum + item.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          /* crossAxisAlignment: CrossAxisAlignment.center, */
          children: groupedTransactionValues.map((item) {
            return ChartBar(
                day: item['day'],
                amount: item['totalSpendingOfDay'],
                spendingPercentOfWeek:
                    totalSpendingOfWeek == 0.0 ? 0.0 : (item['totalSpendingOfDay'] as double) / totalSpendingOfWeek);
          }).toList(),
        ),
      ),
    );
  }
}
