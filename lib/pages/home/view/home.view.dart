import 'package:flutter/material.dart';

import '../../../configs/configs.dart';
import '../../../models/models.dart';
import '../../../pages/pages.dart';
import '../../../services/firebase/fbase.dart';
import '../widgets/widgets.dart';

const Color _bg = Colors.blue;

class HomeView extends StatelessWidget {
  final String title;
  const HomeView({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          sliverAppbar(),
          const _ListTopRCorner(),
          listItems(),
        ],
      ),
    );
  }

  SliverAppBar sliverAppbar() {
    return SliverAppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Padding(padding: EdgeInsets.all(16.0), child: Text(Constants.appName)),
        ],
      ),
      expandedHeight: 230.0,
      floating: false,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: _bg,
          // child: const Center(child: Text('fooo')),
        ),
      ),
    );
  }

  Widget listItems() {
    return StreamBuilder(
      stream: readTransactions(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) return buildSliverBoxCenter(Text('Error: ${snapshot.error.toString()}'));
        if (snapshot.connectionState == ConnectionState.waiting) return buildSliverBoxCenter(const Text('Loading...'));

        final List<MyTransaction> transactions = snapshot.data;
        if (snapshot.hasData && transactions.isNotEmpty) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => TransactionListItem(
                transaction: transactions[index],
                onTap: () {
                  Navigator.of(context).pushNamed(
                    TransactionDetailsView.routeName,
                    arguments: transactions[index],
                  );
                },
              ),
              childCount: transactions.length,
            ),
          );
        }
        return buildSliverBoxCenter(const Text('No Data'));
      },
    );
  }

  SliverToBoxAdapter buildSliverBoxCenter(Widget child) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: Center(child: child),
      ),
    );
  }
}

class _ListTopRCorner extends StatelessWidget {
  const _ListTopRCorner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = 30;
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(color: _bg, height: height),
          Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 2),
            width: double.infinity,
            // height: 30,
            child: const Text('Today'),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(height),
                topRight: Radius.circular(height),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
