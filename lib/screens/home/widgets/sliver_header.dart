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
    final transactionsRef = ref.watch(allTransactionsFromSelectedWeek);
    final transactionListFilter = ref.watch(transactionListFilterProvider.state);
    final totalExpence = ref.watch(totalExpenceOfSelectedWeek);
    final totalIncome = ref.watch(totalIncomeOfSelectedWeek);
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
              // TODO: <08.10.22> decide what to do with this switch
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              //   child: OptionSwitch<TransactionListFilter>(
              //     value: transactionListFilter.state,
              //     onSelect: (selected) => transactionListFilter.state = selected,
              //     optionNames: [option('Expense', totalExpence), option('Income', totalIncome)],
              //     options: const [TransactionListFilter.expense, TransactionListFilter.income],
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
