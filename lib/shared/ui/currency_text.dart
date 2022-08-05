import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../../shared/utils/formatter.dart';

class CurrencyText extends StatelessWidget {
  final double balance;
  final double? mainTextSize;
  final double? superScriptSize;
  const CurrencyText(
    this.balance, {
    this.superScriptSize,
    this.mainTextSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currency = Formatters.currency.format(balance).split('.');
    final textTheme = Theme.of(context).textTheme;
    final superScriptStyle = textTheme.headline6?.copyWith(color: Palette.textLight, fontSize: superScriptSize);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('\$', style: superScriptStyle),
        Text(
          currency[0],
          style: textTheme.headline4?.copyWith(
            color: Colors.grey.shade800,
            height: 1.1,
            fontSize: mainTextSize,
          ),
        ),
        Text('.${currency[1]}', style: superScriptStyle),
      ],
    );
  }
}
