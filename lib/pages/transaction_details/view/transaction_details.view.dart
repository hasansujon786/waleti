import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/providers.dart';
import '../../../models/models.dart';

class TransactionDetailsView extends ConsumerWidget {
  final String title;
  const TransactionDetailsView({Key? key, required this.title}) : super(key: key);

  static const routeName = '/transaction_details';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transaction = ModalRoute.of(context)!.settings.arguments as MyTransaction;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context, transaction);
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(transaction.title),
            Text('${transaction.amount}'),
          ],
        ),
      ),
    );
  }
}
