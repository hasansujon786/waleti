import 'package:flutter/material.dart';

import '../../../models/models.dart';

class DoubleDot extends StatelessWidget {
  final double size;
  final Color? color;
  const DoubleDot(
    this.size, {
    Key? key,
    this.color = const Color(0xffe4ebe0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  factory DoubleDot.fromTransaction(MyTransactionDataType transactionType, [double size = 6]) {
    return DoubleDot(size, color: transactionType == MyTransactionDataType.income ? Colors.green : Colors.red);
  }
}
