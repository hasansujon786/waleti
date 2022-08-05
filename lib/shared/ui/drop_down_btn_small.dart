import 'package:flutter/material.dart';

class DropDownBtnSmall extends StatelessWidget {
  const DropDownBtnSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 6, 14, 6),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Colors.black12, width: 1)
      ),
      child: Text(
        'Week',
        style: textTheme.labelSmall?.copyWith(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
