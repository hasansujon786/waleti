import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../configs/configs.dart';
import '../../../models/models.dart';
import '../../../shared/ui/ui.dart';
import '../../../shared/utils/formatter.dart';

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
      title: Text(transaction.category.name, style: TextStyle(color: Palette.text)),
      subtitle: Text(Formatters.monthDayYear.format(transaction.createdAt), style: Theme.of(context).textTheme.caption),
      trailing: CurrencyText.small(123.33, transaction.type),
    );
  }

  Container leading(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: Colors.grey.shade100,
      ),
      child: Center(child: Icon(transaction.category.icon)),
    );
  }
}
