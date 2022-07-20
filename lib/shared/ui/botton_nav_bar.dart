import 'package:flutter/material.dart';

class BottomNavBarItem {
  BottomNavBarItem({required this.icon, required this.text});
  IconData icon;
  String text;
}

class BottomNavBar extends StatelessWidget {
  final ValueChanged<int> onTabSelected;
  final List<BottomNavBarItem> items;
  final NotchedShape notchedShape;
  final double height;
  final double iconSize;
  final double iconFontSize;
  final int selectedIndex;
  final Color? backgroundColor;

  const BottomNavBar({
    Key? key,
    this.height = 60.0,
    this.iconSize = 24.0,
    this.iconFontSize = 12,
    this.notchedShape = const CircularNotchedRectangle(),
    this.backgroundColor,
    required this.items,
    required this.onTabSelected,
    required this.selectedIndex,
  })  : assert(items.length == 2 || items.length == 4),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final navbarTheme = Theme.of(context).bottomNavigationBarTheme;

    List<Widget> navItems = List.generate(items.length, (int index) {
      return _NavItem(
        iconFontSize: iconFontSize,
        itemColor: selectedIndex == index ? navbarTheme.selectedItemColor : navbarTheme.unselectedItemColor,
        iconSize: iconSize,
        height: height,
        itemData: items[index],
        index: index,
        onPressed: (int index) {
          onTabSelected(index);
        },
      );
    });
    navItems.insertAll(items.length >> 1, _buildMiddleItemGap());

    return BottomAppBar(
      notchMargin: 6,
      shape: notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navItems,
      ),
      color: backgroundColor ?? navbarTheme.backgroundColor,
    );
  }

  List<Widget> _buildMiddleItemGap() {
    return [
      SizedBox(height: height, width: 9),
      Expanded(child: SizedBox(height: height)),
      SizedBox(height: height, width: 9),
    ];
  }
}

class _NavItem extends StatelessWidget {
  final BottomNavBarItem itemData;
  final ValueChanged<int> onPressed;
  final int index;
  final double height;
  final Color? itemColor;
  final double iconFontSize;
  final double iconSize;
  const _NavItem({
    Key? key,
    required this.itemData,
    required this.index,
    required this.onPressed,
    required this.height,
    required this.itemColor,
    required this.iconSize,
    required this.iconFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(itemData.icon, color: itemColor, size: iconSize),
                Text(itemData.text, style: TextStyle(color: itemColor, fontSize: iconFontSize))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavBarPadding extends StatelessWidget {
  final Widget child;
  const BottomNavBarPadding({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: child,
    );
  }
}
