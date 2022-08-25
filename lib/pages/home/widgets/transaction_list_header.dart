import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waleti/providers/providers.dart';

class TransactionListHeader extends ConsumerWidget {
  final bool isTransactionsView;
  final void Function(bool) toggleTransactioView;
  final Color bg;
  const TransactionListHeader({
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
