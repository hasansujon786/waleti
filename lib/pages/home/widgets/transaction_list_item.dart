import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../shared/utils/formatter.dart';
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(transaction.title, style: TextStyle(color: Palette.text)),
          currency(),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Shoping', style: Theme.of(context).textTheme.caption),
          Text(Formatters.monthDayYear.format(transaction.createdAt), style: Theme.of(context).textTheme.caption),
        ],
      ),
    );
  }

  RichText currency() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(color: Palette.text, fontWeight: FontWeight.w500),
        children: [
          TextSpan(text: transaction.type == MyTransactionDataType.income ? '+ ' : '- '),
          const WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Text(
              '\$ ',
              style: TextStyle(fontSize: 11),
            ),
          ),
          TextSpan(text: '${transaction.amount}')
        ],
      ),
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
      // child: Center(
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Text('Jan', style: textStyle),
      //       Text('25', style: textStyle),
      //     ],
      //   ),
      // ),
    );
  }
}
