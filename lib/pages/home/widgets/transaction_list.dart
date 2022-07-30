import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/controllers.dart';
import '../../../models/models.dart';
import '../../../pages/pages.dart';
import 'widgets.dart';

class TransactionList extends ConsumerWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final filteredTransactions = ref.watch(filteredTransactionsListProvider);
    return filteredTransactions.when(
        data: (transactions) => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => TransactionListItem(
                  transaction: transactions[index],
                  onTap: () async {
                    final deleteTransaction = await Navigator.of(context).pushNamed(
                      TransactionDetailsView.routeName,
                      arguments: index,
                    ) as MyTransaction?;
                    if (deleteTransaction != null) {
                      ref.read(transactionListControllerProvider.notifier).deleteItem(item: deleteTransaction);
                    }
                  },
                ),
                childCount: transactions.length,
              ),
            ),
        error: (e, _) => buildSliverBoxCenter(const Text('error')),
        loading: () => buildSliverBoxCenter(const Text('Loading...')));
  }

  SliverToBoxAdapter buildSliverBoxCenter(Widget child) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: Center(child: child),
      ),
    );
  }
}
