import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../shared/utils/formatter.dart';

class CurrencyText extends StatelessWidget {
  final double amout;
  final double? mainTextSize;
  final double? superScriptSize;
  final MyTransactionDataType? type;
  final bool small;
  const CurrencyText(
    this.amout, {
    Key? key,
    this.superScriptSize,
    this.mainTextSize,
    this.type,
    this.small = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currency = Formatters.currency.format(amout).split('.');
    final textTheme = Theme.of(context).textTheme;
    return small ? smallText(currency, type: type) : largeText(currency, textTheme);
  }

  Widget largeText(List<String> currency, TextTheme textTheme) {
    final superScriptStyle = textTheme.headline6?.copyWith(color: Colors.white70, fontSize: superScriptSize);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('\$', style: superScriptStyle),
        Text(
          currency[0],
          style: textTheme.headline4?.copyWith(
            color: Colors.grey.shade300,
            height: 1.1,
            fontSize: mainTextSize,
          ),
        ),
        Text('.${currency[1]}', style: superScriptStyle),
      ],
    );
  }

  Widget smallText(List<String> currency, {required MyTransactionDataType? type}) {
    final typeColor = type == MyTransactionDataType.income ? Colors.green : Colors.red[300];
    final smallStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: typeColor);

    return RichText(
      text: TextSpan(
        style: TextStyle(color: typeColor, fontWeight: FontWeight.w500, fontSize: 16),
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: type == MyTransactionDataType.income
                ? Icon(Icons.add, size: 10, color: typeColor)
                : Icon(Icons.remove, size: 10, color: typeColor),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.only(right: 1),
              child: Text('\$', style: smallStyle.copyWith(fontSize: 12)),
            ),
          ),
          TextSpan(text: currency[0]),
          TextSpan(text: '.${currency[1]}', style: smallStyle)
        ],
      ),
    );
  }

  factory CurrencyText.small(double amount, [MyTransactionDataType? type]) {
    return CurrencyText(amount, type: type, small: true);
  }
}
