import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/controllers.dart';
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
              ref.read(transactionListControllerProvider.notifier).deleteItem(itemId: transaction.id);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          ),
          const SizedBox(width: 4)
        ],
      ),
      body: Center(
        child: Text(transaction.title),
      ),
    );
  }
}
