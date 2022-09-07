import 'package:flutter/material.dart';

import '../../../configs/configs.dart';
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
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              title: Text(Constants.appName, style: TextStyle(color: _bg)),
              expandedHeight: 320,
              pinned: true,
              stretch: true,
              flexibleSpace: SliverHeaderContent(bg: _bg),
            ),
            TransactionListHeader(
              bg: _bg,
              isTransactionsView: _isTransactionView,
              toggleTransactioView: toggleTransactioView,
            ),
            TransactionList(isTransactionsView: _isTransactionView),
            const SliverToBoxAdapter(child: SizedBox(height: 40))
          ],
        ),
      ),
    );
  }
}
