import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../configs/configs.dart';
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
    final superScriptStyle = textTheme.headline6?.copyWith(color: Palette.textLight, fontSize: superScriptSize);
    return Row(
      mainAxisSize: MainAxisSize.min,
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

  Widget smallText(List<String> currency, {required MyTransactionDataType? type}) {
    final smallStyle = TextStyle(fontSize: 10, color: Palette.textLight, fontWeight: FontWeight.w700);
    final typeColor = type == MyTransactionDataType.income ? Colors.green : Colors.red[300];

    return RichText(
      text: TextSpan(
        style: TextStyle(color: Palette.text, fontWeight: FontWeight.w500, fontSize: 16),
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (type != null) Text('●', style: TextStyle(color: typeColor)),
                    Text(' \$', style: smallStyle.copyWith(fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 2),
              ],
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
