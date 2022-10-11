import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../configs/configs.dart';
import '../../../models/models.dart';
import '../../../shared/ui/ui.dart';
import '../../../extensions/date_time_extension.dart';

class TransactionListItem extends StatelessWidget {
  final MyTransaction transaction;
  final Function(MyTransaction) onItemTap;
  final dateFormater = DateFormat().add_yMMMd();
  TransactionListItem({
    Key? key,
    required this.onItemTap,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onItemTap(transaction),
      horizontalTitleGap: 8,
      leading: leading(context),
      title: Text(transaction.category.name, style: TextStyle(color: Palette.text)),
      subtitle: Text(transaction.createdAt.relateiveDate(), style: Theme.of(context).textTheme.caption),
      trailing: CurrencyText.small(transaction.amount, transaction.type),
    );
  }

  Container leading(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: Colors.grey.shade50,
      ),
      child: Center(child: Icon(transaction.category.icon)),
    );
  }
}
