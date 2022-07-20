import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(
      {Key? key,
      required this.day,
      required this.amount,
      required this.spendingPercentOfWeek})
      : super(key: key);

  final dynamic day;
  final dynamic amount;
  final double spendingPercentOfWeek;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Column(children: [
        Text('$day'),
        const SizedBox(height: 4),
        Flexible(
          child: Stack(
            children: [
              Container(
                width: 10,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPercentOfWeek,
                child: Container(
                  width: 10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 20,
          child: FittedBox(
            child: Text('\$${amount.toStringAsFixed(0)}'),
          ),
        ),
      ]),
    );
  }
}
