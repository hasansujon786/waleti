import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../configs/configs.dart';
import '../../../models/models.dart';

class TransactionListItem extends StatelessWidget {
  final MyTransaction transaction;
  final VoidCallback onTap;
  final dateFormater = DateFormat().add_yMMMd();
  TransactionListItem({
    Key? key,
    required this.transaction,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 8,
      leading: leading(context),
      title: Text(
        transaction.title,
        style: TextStyle(color: Palette.text),
      ),
      subtitle: Text(
        dateFormater.format(transaction.createdAt),
        style: Theme.of(context).textTheme.caption,
      ),
      trailing: Text(
        '${transaction.type == MyTransactionDataType.income ? '+' : '-'} \$ ${transaction.amount}',
        style: TextStyle(color: Palette.text, fontWeight: FontWeight.w500),
      ),
      // trailing: IconButton(
      //   icon: const Icon(Icons.delete),
      //   onPressed: () => onDeleteTransaction(transaction.id),
      // ),
    );
  }

  Container leading(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.caption?.copyWith(
          fontWeight: FontWeight.w500,
          color: Palette.textLight,
        );
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: Colors.grey.shade200,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Jan', style: textStyle),
            Text('25', style: textStyle),
          ],
        ),
      ),
    );
  }
}
