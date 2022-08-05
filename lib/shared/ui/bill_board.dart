import 'package:flutter/material.dart';

import 'ui.dart';

class BillBoard extends StatelessWidget {
  final double currentBalance;
  const BillBoard({
    Key? key,
    required this.currentBalance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                'Today',
                // 'September 23, 2022',
                style: textTheme.titleSmall,
              ),
              const SizedBox(height: 6),
              curBalanceTitle(textTheme),
              const SizedBox(height: 2),
              CurrencyText(currentBalance),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('My Account', style: textTheme.labelSmall?.copyWith(color: Colors.grey.shade600)),
              userAccount(textTheme),
              const SizedBox(height: 2),
              const DropDownBtnSmall()
            ],
          ),
        ],
      ),
    );
  }

  Widget userAccount(TextTheme textTheme) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(text: '● ', style: TextStyle(color: Colors.blue.shade500)),
          const TextSpan(text: '\$23.00'),
        ],
      ),
    );
  }

  RichText curBalanceTitle(TextTheme textTheme) {
    return RichText(
      text: TextSpan(
        style: textTheme.labelSmall?.copyWith(color: Colors.black54),
        children: [
          TextSpan(
            text: '●',
            style: TextStyle(
              fontSize: 14,
              height: 0.5,
              color: Colors.red[300],
            ),
          ),
          const TextSpan(text: ' Total Expanse'),
        ],
      ),
    );
  }
}
