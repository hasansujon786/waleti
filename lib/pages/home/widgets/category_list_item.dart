import 'package:flutter/material.dart';

import '../../../configs/configs.dart';
import '../../../models/models.dart';
import '../../../shared/ui/ui.dart';
import '../../../shared/utils/utisls.dart';

class CategoryListItem extends StatelessWidget {
  final CatetoryItemData data;
  final Function(MyTransaction) onItemTap;
  const CategoryListItem(this.data, {Key? key, required this.onItemTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
        listTileTheme: const ListTileThemeData(minLeadingWidth: 8),
        expansionTileTheme: ExpansionTileThemeData(
          iconColor: Colors.deepPurple[400],
          collapsedIconColor: Palette.textMuted,
          textColor: Colors.deepPurple[400],
          collapsedTextColor: Colors.grey.shade700,
        ),
        // iconTheme: IconThemeData(size: 20)
      ),
      child: ExpansionTile(
        key: UniqueKey(),
        controlAffinity: ListTileControlAffinity.leading,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(data.category.icon, size: 24, color: Colors.black54),
            const SizedBox(width: 16),
            Text(data.category.name, style: const TextStyle(fontWeight: FontWeight.w500)),
            const Spacer(),
            CurrencyText.small(data.total),
          ],
        ),
        childrenPadding: const EdgeInsets.only(left: 40),
        children: data.items.map((e) => innerItemTile(e, context)).toList(),
      ),
    );
  }

  Widget innerItemTile(MyTransaction item, context) {
    return ListTile(
      onTap: () => onItemTap(item),
      title: CurrencyText.small(item.amount, item.type),
      trailing: Text(Formatters.monthDay.format(item.createdAt), style: Theme.of(context).textTheme.caption),
    );
  }
}
