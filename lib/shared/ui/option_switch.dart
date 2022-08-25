import 'package:flutter/material.dart';

final _alignments = [Alignment.centerLeft, Alignment.centerRight];

class OptionSwitch<T> extends StatelessWidget {
  final T value;
  final List<T> options;
  final List<Widget> optionNames;
  final Function(T) onSelect;
  final double margin;

  const OptionSwitch({
    Key? key,
    required this.value,
    required this.options,
    required this.optionNames,
    required this.onSelect,
    this.margin = 0.00,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedIndex = options.indexWhere((opt) => opt == value);

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
            alignment: _alignments[selectedIndex],
            duration: const Duration(milliseconds: 280),
            child: FractionallySizedBox(
              widthFactor: 1 / optionNames.length,
              child: Container(
                margin: EdgeInsets.all(margin),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Row(
            children: [
              for (var i = 0; i < options.length; i++)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (selectedIndex == i) return;
                      onSelect(options[i]);
                    },
                    child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: AnimatedDefaultTextStyle(
                        style: TextStyle(
                          color: i == selectedIndex ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                        duration: const Duration(milliseconds: 200),
                        child: optionNames[i],
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
