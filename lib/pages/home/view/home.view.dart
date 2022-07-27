import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/controllers.dart';
import '../widgets/widgets.dart';

class HomeView extends ConsumerWidget {
  final String title;
  const HomeView({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final transactions = ref.watch(transactionListControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverHeader(userTransactions: transactions.value ?? []),
          const SliverListTopRCorner(child: Text('Transactions')),
          const TransactionList(),
        ],
      ),
    );
  }
}
