import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class HomeView extends StatelessWidget {
  final String title;
  const HomeView({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverHeader(),
          SliverListTopRCorner(),
          TransactionList(),
        ],
      ),
    );
  }
}
