import 'package:flutter/material.dart';

class PopupMenuItemData extends StatelessWidget {
  final IconData icon;
  final String text;

  const PopupMenuItemData({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      horizontalTitleGap: 12,
      minVerticalPadding: 0,
      minLeadingWidth: 0,
      leading: Icon(icon),
      title: Text(text),
    );
  }
}
