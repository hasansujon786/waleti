import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/configs.dart';
import '../../../controllers/controllers.dart';
import '../../../shared/ui/ui.dart';

// const _bg = Colors.blue;
const _bg = Color(0xffF8FAF7);

class SliverHeader extends ConsumerWidget {
  const SliverHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final transactions = ref.watch(filteredTransactionsListProvider);

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
                child: transactions.when(
                  data: (data) => LineChartWrapper(userTransactions: data),
                  error: (e, _) => Text(e.toString()),
                  loading: () => const Center(child: Text('Loading')),
                ),
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

class SliverListTopRCorner extends ConsumerWidget {
  const SliverListTopRCorner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Transactions'),
                  IconButton(
                    onPressed: () {
                      ref.read(transactionListControllerProvider.notifier).deleteAllTransactions();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ],
              ),
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
