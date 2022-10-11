import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  const IconBox({super.key, required this.icon, this.bg});

  final Widget? icon;
  final Color? bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: bg ?? Colors.teal.shade400,
      ),
      child: icon,
    );
  }
}
