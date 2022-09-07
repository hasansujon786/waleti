import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/controllers.dart';
import '../../../shared/ui/ui.dart';

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
              padding: const EdgeInsets.fromLTRB(20, 8, 8, 4),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.vertical(top: Radius.circular(height)),
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    isTransactionsView ? 'Transactions' : 'Category',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const Spacer(),
                  CircularButton(
                    icon: Icon(isTransactionsView ? Icons.list_alt : Icons.list),
                    onPressed: () => toggleTransactioView(!isTransactionsView),
                  ),
                  moreButton(ref)
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

  Widget moreButton(WidgetRef ref) {
    return PopupMenuButton<_PopupOptions>(
      onSelected: (value) {
        switch (value) {
          case _PopupOptions.deleteAll:
            ref.read(transactionListControllerProvider.notifier).deleteAllTransactions();
            break;
          default:
        }
      },
      itemBuilder: (contex) => [
        const PopupMenuItem(
          value: _PopupOptions.deleteAll,
          child: PopupMenuItemData(icon: Icons.clear, text: 'Delete all'),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}

enum _PopupOptions { deleteAll }
