import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/controllers.dart';
import '../../../providers/providers.dart';
import '../../../shared/ui/ui.dart';

class HomeDashboard extends ConsumerWidget {
  final Color bg;
  const HomeDashboard({Key? key, required this.bg}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final transactionsRef = ref.watch(currentTransactionsFilterByWeek);
    final transactionListFilter = ref.watch(transactionListFilterProvider.state);
    final totalExpence = ref.watch(thisWeekTotalExpenceAmount);
    final totalIncome = ref.watch(thisWeekTotalIncomeAmount);
    final currentWeekDates = ref.watch(weekViewControllerProvider);

    return transactionsRef.when(
      data: (transactions) => FlexibleSpaceBar(
        background: Container(
          color: bg,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 70),
              Expanded(
                child: LineChartWrapper(
                  currentSelectedDates: currentWeekDates,
                  userTransactions: transactions,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              //   child: OptionSwitch<TransactionListFilter>(
              //     value: transactionListFilter.state,
              //     onSelect: (selected) => transactionListFilter.state = selected,
              //     optionNames: [option('Expanse', totalExpence), option('Income', totalIncome)],
              //     options: const [TransactionListFilter.expanse, TransactionListFilter.income],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      error: (e, _) => Text(e.toString()),
      loading: () => const Center(child: Text('Loading')),
    );
  }

  Widget option(String title, AsyncValue<double> amount) {
    return Column(
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
}
