import 'package:flutter/material.dart';

class TestView extends StatelessWidget {
  final String title;
  const TestView({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
