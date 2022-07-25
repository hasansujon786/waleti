import 'package:flutter/material.dart';

class TabularSwitch<T> extends StatefulWidget {
  final List<String> optionNames;
  final List<T> options;
  final Function(T) onSelect;
  final double margin;
  const TabularSwitch({
    Key? key,
    required this.optionNames,
    required this.options,
    required this.onSelect,
    this.margin = 0.00,
  }) : super(key: key);

  @override
  State<TabularSwitch<T>> createState() => _TabularSwitchState<T>();
}

class _TabularSwitchState<T> extends State<TabularSwitch<T>> {
  static final _alignments = [Alignment.centerLeft, Alignment.centerRight];
  var _colors = [Colors.white, Colors.black];
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            curve: Curves.fastOutSlowIn,
            alignment: _alignments[_selectedIndex],
            duration: const Duration(milliseconds: 280),
            child: FractionallySizedBox(
              widthFactor: 1 / widget.optionNames.length,
              child: Container(
                margin: EdgeInsets.all(widget.margin),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Row(
            children: [
              for (var i = 0; i < widget.options.length; i++)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (_selectedIndex == i) return;
                      setState(() {
                        _selectedIndex = i;
                        _colors = _colors.reversed.toList();
                      });
                      widget.onSelect(widget.options[i]);
                    },
                    child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: AnimatedDefaultTextStyle(
                        style: TextStyle(color: _colors[i]),
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          widget.optionNames[i],
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
