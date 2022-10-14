import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/controllers.dart';
import '../../../models/models.dart';
import '../../../screens/screens.dart';
import '../../../providers/providers.dart';
import 'widgets.dart';

class TransactionList extends ConsumerWidget {
  final bool isTransactionsView;
  const TransactionList({Key? key, this.isTransactionsView = true}) : super(key: key);

  void navigateToTransaction(BuildContext context, WidgetRef ref, MyTransaction item) async {
    final deleteTransaction = await Navigator.of(context).pushNamed(
      TransactionDetailsView.routeName,
      arguments: item,
    ) as MyTransaction?;
    if (deleteTransaction != null) {
      ref.read(transactionListControllerProvider.notifier).deleteItem(item: deleteTransaction);
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    return ref.watch(allTransactionsFromSelectedWeek).when(
          data: (transactions) {
            return isTransactionsView
                ? transactionViewbuilder(transactions, ref)
                : categoryViewBuilder(transactions, ref);
          },
          error: (e, _) => buildSliverBoxCenter(const Text('error')),
          loading: () => buildSliverBoxCenter(const Text('Loading...')),
        );
  }

  SliverList categoryViewBuilder(List<MyTransaction> transactions, WidgetRef ref) {
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
          return CategoryListItem(
            data,
            onItemTap: (item) => navigateToTransaction(context, ref, item),
          );
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
          onItemTap: (item) => navigateToTransaction(context, ref, item),
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
