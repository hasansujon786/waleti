import 'package:flutter/material.dart';

class CustomSwitch<T> extends StatefulWidget {
  final List<String> optionNames;
  final List<T> options;
  final Function(T) onSelect;
  const CustomSwitch({
    Key? key,
    required this.optionNames,
    required this.options,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<CustomSwitch<T>> createState() => _CustomSwitchState<T>();
}

class _CustomSwitchState<T> extends State<CustomSwitch<T>> {
  static final _alignments = [Alignment.centerLeft, Alignment.centerRight];
  var _colors = [Colors.white, Colors.black];
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
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
                margin: const EdgeInsets.all(6),
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
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          child: Text(
                            widget.optionNames[i],
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: TextStyle(color: _colors[i]),
                          duration: const Duration(milliseconds: 200),
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
