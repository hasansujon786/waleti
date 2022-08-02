import 'package:flutter/material.dart';

class BillBoard extends StatelessWidget {
  const BillBoard({Key? key}) : super(key: key);

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
              chip(textTheme),
              currentBalance(textTheme),
            ],
          ),
          userAccount(textTheme),
        ],
      ),
    );
  }

  Column userAccount(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('My Account', style: textTheme.labelSmall?.copyWith(color: Colors.grey.shade600)),
        const SizedBox(height: 2),
        RichText(
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
        ),
      ],
    );
  }

  Column currentBalance(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 6),
        RichText(
          text: TextSpan(
            style: textTheme.labelSmall?.copyWith(color: Colors.black),
            children: [
              TextSpan(
                text: '●',
                style: TextStyle(
                  fontSize: 14,
                  height: 0.5,
                  color: Colors.red[600],
                ),
              ),
              const TextSpan(text: ' Total Expanse'),
            ],
          ),
        ),
        const SizedBox(height: 2),
        RichText(
          text: TextSpan(
            style: textTheme.bodySmall,
            children: [
              TextSpan(
                text: '\$2323.00',
                style: textTheme.headline4?.copyWith(
                  color: Colors.grey.shade800,
                ),
              ),
              const TextSpan(text: ' TK'),
            ],
          ),
        ),
      ],
    );
  }

  Widget chip(TextTheme textTheme) {
    return Row(
      children: [
        Text(
          'Last 7 days',
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const RotatedBox(
          quarterTurns: 1,
          child: Icon(Icons.chevron_right_rounded, size: 22),
        )
      ],
    );
  }
}
