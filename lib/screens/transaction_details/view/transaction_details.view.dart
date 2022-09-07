import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/controllers.dart';
import '../../../models/models.dart';

class TransactionDetailsView extends StatefulWidget {
  final BuildContext parentContext;
  const TransactionDetailsView(this.parentContext, {Key? key}) : super(key: key);

  static const routeName = '/transaction_details';

  @override
  State<TransactionDetailsView> createState() => _TransactionDetailsViewState();
}

class _TransactionDetailsViewState extends State<TransactionDetailsView> {
  late MyTransaction selectedTransaction;

  @override
  void initState() {
    super.initState();
    selectedTransaction = ModalRoute.of(widget.parentContext)?.settings.arguments as MyTransaction;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        actions: [
          IconButton(
            onPressed: () => confirmDeleteTransaction(context, selectedTransaction),
            icon: const Icon(Icons.delete),
          ),
          const SizedBox(width: 4)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(selectedTransaction.category.icon),
                const SizedBox(width: 12),
                Text(selectedTransaction.category.name),
              ],
            ),
            const SizedBox(height: 8),
            Text('${selectedTransaction.amount}'),
            const SizedBox(height: 20),
            Consumer(
              builder: (context, ref, child) => TextButton.icon(
                label: const Text('Update amount'),
                onPressed: () {
                  final item = selectedTransaction;
                  item.amount = 500;
                  setState(() => selectedTransaction = item);
                  ref.read(transactionListControllerProvider.notifier).updateItem(updatedItem: item);
                },
                icon: const Icon(Icons.update),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future confirmDeleteTransaction(context, MyTransaction transaction) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete transaction'),
        content: const Text('Confirm to delete?'),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, transaction);
            },
          )
        ],
      ),
    );
  }
}
