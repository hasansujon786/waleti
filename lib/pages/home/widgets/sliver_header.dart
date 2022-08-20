import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/configs.dart';
import '../../../controllers/controllers.dart';
import '../../../shared/ui/ui.dart';

class SliverHeader extends ConsumerWidget {
  final Color bg;
  const SliverHeader({Key? key, required this.bg}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final transactions = ref.watch(filteredTransactionsListProvider);

    return SliverAppBar(
      title: Text(Constants.appName, style: TextStyle(color: bg)),
      expandedHeight: 320,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: bg,
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

class SliverListTopHeader extends ConsumerWidget {
  final bool isTransactionsView;
  final void Function(bool) toggleTransactioView;
  final Color bg;
  const SliverListTopHeader({
    Key? key,
    this.isTransactionsView = true,
    required this.toggleTransactioView,
    required this.bg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final mq = MediaQuery.of(context);
    double height = 25;
    return SliverToBoxAdapter(
      child: ColoredBox(
        color: bg,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: mq.size.width,
              padding: const EdgeInsets.fromLTRB(20, 8, 8, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.vertical(top: Radius.circular(height)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  DropdownButton<bool>(
                    onChanged: ((value) {
                      if (value == null) return;
                      toggleTransactioView(value);
                    }),
                    hint: Text(
                      isTransactionsView ? 'Transactions' : 'Category',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    underline: const SizedBox(),
                    // value: _showListView,
                    items: const [
                      DropdownMenuItem(
                        value: true,
                        child: Text('Transactions', style: TextStyle(fontSize: 14)),
                      ),
                      DropdownMenuItem(
                        value: false,
                        child: Text('Category', style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => ref.read(transactionListControllerProvider.notifier).deleteAllTransactions(),
                    icon: const Icon(Icons.clear),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: -2,
              right: 0,
              height: 4,
              left: 0,
              child: ColoredBox(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
