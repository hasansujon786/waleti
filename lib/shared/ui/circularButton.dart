import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: const CircleBorder(),
        foregroundColor: Colors.grey.shade800,
        // backgroundColor: Colors.deepPurple.shade50,
        fixedSize: const Size.square(48),
        minimumSize: const Size.square(20),
      ),
      onPressed: onPressed,
      child: icon,
    );
  }
}
