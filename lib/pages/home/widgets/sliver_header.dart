import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/providers.dart';
import '../../../shared/ui/ui.dart';
import '../../../shared/utils/dateTime_utils.dart';

class SliverHeaderContent extends ConsumerWidget {
  final Color bg;
  const SliverHeaderContent({Key? key, required this.bg}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final transactionsRef = ref.watch(currentTransactionsFilterByWeek);
    final transactionListFilter = ref.watch(transactionListFilterProvider.state);
    final totalExpence = ref.watch(thisWeekTotalExpenceAmount);
    final totalIncome = ref.watch(thisWeekTotalIncomeAmount);

    return transactionsRef.when(
      data: (transactions) => FlexibleSpaceBar(
        background: Container(
          color: bg,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: LineChartWrapper(
                  todayNameIndex: todayIndexFromWeek(),
                  userTransactions: transactions,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: OptionSwitch<TransactionListFilter>(
                  value: transactionListFilter.state,
                  onSelect: (selected) => transactionListFilter.state = selected,
                  optionNames: [option('Expanse', totalExpence), option('Income', totalIncome)],
                  options: const [TransactionListFilter.expanse, TransactionListFilter.income],
                ),
              ),
            ],
          ),
        ),
      ),
      error: (e, _) => Text(e.toString()),
      loading: () => const Center(child: Text('Loading')),
    );
  }

  Widget option(String title, AsyncValue<double> amount) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          const SizedBox(height: 3),
          Opacity(
            opacity: 0.6,
            child: Text(
              '\$ ${amount.value}',
              style: const TextStyle(
                fontSize: 10,
                letterSpacing: 0.3,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      );
}
