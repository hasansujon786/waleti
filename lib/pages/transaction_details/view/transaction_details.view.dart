import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waleti/models/models.dart';

import '../../../controllers/controllers.dart';

class TransactionDetailsView extends ConsumerWidget {
  final String title;
  const TransactionDetailsView({Key? key, required this.title}) : super(key: key);

  static const routeName = '/transaction_details';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curIndex = ModalRoute.of(context)!.settings.arguments as int;

    return ref.watch(transactionListControllerProvider).when(
        data: ((transactions) {
          final transaction = transactions.length > curIndex ? transactions[curIndex] : MyTransaction.empty();

          return Scaffold(
            appBar: AppBar(
              title: const Text('Transaction Details'),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context, transaction.id);
                  },
                  icon: const Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {
                    final item = transaction;
                    item.title = 'updated';
                    ref.read(transactionListControllerProvider.notifier).updateItem(updatedItem: item);
                  },
                  icon: const Icon(Icons.update),
                ),
                const SizedBox(width: 4)
              ],
            ),
            body: Center(
              child: Text(transaction.title),
            ),
          );
        }),
        error: (error, stackTrace) => const Text('error'),
        loading: () => const Text('loading...'));
  }
}
