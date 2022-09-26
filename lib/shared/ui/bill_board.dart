import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import 'ui.dart';

class BillBoard extends ConsumerWidget {
  const BillBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final textTheme = Theme.of(context).textTheme;
    final cDayTrans = ref.watch(transactionsFromCurrentSelectedDayProvider);
    final curSelectedDayBalance = cDayTrans.value?.fold<double>(0, (sum, item) => sum + item.amount) ?? 0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              curBalanceTitle(textTheme),
              const SizedBox(height: 2),
              CurrencyText(curSelectedDayBalance),
            ],
          ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     Text('My Account', style: textTheme.labelSmall?.copyWith(color: Colors.grey.shade600)),
          //     userAccount(textTheme),
          //     const SizedBox(height: 2),
          //     const DropDownBtnSmall()
          //   ],
          // ),
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
