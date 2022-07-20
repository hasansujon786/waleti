import 'package:flutter/material.dart';

import '../../../models/models.dart';
import '../../../services/firebase/fbase.dart';

class TransactionDetailsView extends StatelessWidget {
  final String title;
  const TransactionDetailsView({Key? key, required this.title}) : super(key: key);

  static const routeName = '/transaction_details';
  @override
  Widget build(BuildContext context) {
    final transaction = ModalRoute.of(context)!.settings.arguments as MyTransaction;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        actions: [
          IconButton(
            onPressed: () {
              deleteSingleTransaction(transaction.id);
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
