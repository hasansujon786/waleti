import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

// const _bg = Colors.blue;
const _bg = Color(0xffF8FAF7);

class HomeView extends StatefulWidget {
  final String title;
  const HomeView({Key? key, required this.title}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isTransactionView = true;
  void toggleTransactioView(bool value) {
    setState(() {
      _isTransactionView = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverHeader(bg: _bg),
          SliverListTopHeader(
            bg: _bg,
            isTransactionsView: _isTransactionView,
            toggleTransactioView: toggleTransactioView,
          ),
          TransactionList(isTransactionsView: _isTransactionView),
        ],
      ),
    );
  }
}
