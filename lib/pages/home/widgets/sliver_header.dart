import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../configs/configs.dart';
import '../../../controllers/controllers.dart';
import '../../../extensions/date_time_extension.dart';
import '../../../models/models.dart';
import '../../../shared/ui/ui.dart';

// const _bg = Colors.blue;
const _bg = Color(0xffF8FAF7);

class SliverHeader extends StatelessWidget {
  final List<MyTransaction> userTransactions;
  const SliverHeader({
    Key? key,
    this.userTransactions = const [],
  }) : super(key: key);

  List<MyTransaction> get lastWeekTransactions {
    return userTransactions.where((tx) {
      return tx.createdAt.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  double get totalSpendingOfWeek {
    return lastWeekTransactions.fold(0, (sum, item) => sum + item.amount);
  }

  DateTime get today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  List<ChartBarItemDataOfDay> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final dateToCheck = DateTime.now().subtract(Duration(days: index));
        double totalsum = 0.0;
        for (var i = 0; i < lastWeekTransactions.length; i++) {
          if (lastWeekTransactions[i].createdAt.isSameDayAs(dateToCheck)) {
            totalsum += lastWeekTransactions[i].amount;
          }
        }

        return ChartBarItemDataOfDay(
          isToday: dateToCheck.isToday,
          date: dateToCheck.day,
          day: DateFormat.E().format(dateToCheck),
          totalSpendingOfDay: totalsum,
          spendignPercentace: totalsum / totalSpendingOfWeek,
        );
      },
    ).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text(Constants.appName, style: TextStyle(color: _bg)),
      expandedHeight: 320,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: _bg,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 24),
              Expanded(
                child: userTransactions.isNotEmpty
                    ? LineChartWrapper(weeklyTransactionsData: groupedTransactionValues)
                    : const Center(child: Text('Empty')),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Consumer(
                  builder: (context, ref, child) {
                    var transactionListFilter = ref.watch(transactionListFilterProvider.state);
                    return OptionSwitch<TransactionListFilter>(
                      value: transactionListFilter.state,
                      onSelect: (selected) => transactionListFilter.state = selected,
                      optionNames: const ['Expanse', 'Income'],
                      options: const [TransactionListFilter.expanse, TransactionListFilter.income],
                    );
                  },
                ),
              )
            ],
          ),
          // child: const Center(child: Text('fooo')),
        ),
      ),
    );
  }
}

class SliverListTopRCorner extends StatelessWidget {
  final Widget child;
  const SliverListTopRCorner({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    double height = 25;
    return SliverToBoxAdapter(
      child: Container(
        color: _bg,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: mq.size.width,
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 2),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(height),
                  topRight: Radius.circular(height),
                ),
              ),
              child: child,
            ),
            Positioned(
              bottom: -2,
              right: 0,
              height: 4,
              width: mq.size.width,
              child: Container(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
