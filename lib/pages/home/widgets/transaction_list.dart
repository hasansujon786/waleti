import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/controllers.dart';
import '../../../models/models.dart';
import '../../../pages/pages.dart';
import 'widgets.dart';

class TransactionList extends ConsumerWidget {
  final bool isTransactionsView;
  const TransactionList({Key? key, this.isTransactionsView = true}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final filteredTransactions = ref.watch(filteredTransactionsListProvider);
    return filteredTransactions.when(
        data: (transactions) {
          return isTransactionsView ? transactionViewbuilder(transactions, ref) : categoryViewBuilder(transactions);
        },
        error: (e, _) => buildSliverBoxCenter(const Text('error')),
        loading: () => buildSliverBoxCenter(const Text('Loading...')));
  }

  SliverList categoryViewBuilder(List<MyTransaction> transactions) {
    final categoryData = transactions.fold(<String, CatetoryItemData>{}, (Map<String, CatetoryItemData> acc, curItem) {
      final key = curItem.category.name;
      final entry = acc[key];

      acc[key] = entry == null
          ? CatetoryItemData(category: curItem.category, items: [curItem], total: curItem.amount)
          : CatetoryItemData(
              category: curItem.category,
              items: [...entry.items, curItem],
              total: entry.total + curItem.amount,
            );
      return acc;
    });
    final categoryKeys = categoryData.keys.toList();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final data = categoryData[categoryKeys[index]];
          if (data == null) return const SizedBox();
          return CategoryListItem(data);
        },
        childCount: categoryKeys.length,
      ),
    );
  }

  Widget transactionViewbuilder(List<MyTransaction> transactions, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => TransactionListItem(
          transaction: transactions[index],
          onTap: () async {
            final deleteTransaction = await Navigator.of(context).pushNamed(
              TransactionDetailsView.routeName,
              arguments: transactions[index],
            ) as MyTransaction?;
            if (deleteTransaction != null) {
              ref.read(transactionListControllerProvider.notifier).deleteItem(item: deleteTransaction);
            }
          },
        ),
        childCount: transactions.length,
      ),
    );
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
