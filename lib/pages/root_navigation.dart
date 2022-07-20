import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dummy/user/user.dart';
import '../../../services/firebase/fbase.dart';
import '../configs/configs.dart';
import '../shared/ui/ui.dart';
import 'home/home.dart';

class RootNavigation extends StatefulWidget {
  const RootNavigation({Key? key}) : super(key: key);

  static const routeName = '/';
  @override
  State<RootNavigation> createState() => _RootNavigationState();
}

class _RootNavigationState extends State<RootNavigation> {
  static const List<Widget> _screens = <Widget>[
    HomeView(title: Constants.appName),
    TestView(title: 'one'),
    TestView(title: 'two'),
    UsersView(title: 'Users'),
  ];

  int _currentViewIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _currentViewIndex == 0 ? Colors.white : null,
        body: _screens.elementAt(_currentViewIndex),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Consumer(
          builder: (context, ref, child) => FloatingActionButton(
            onPressed: () {
              NewTransactionInputModal.open(context, (newTransaction) {
                // ref.read(transactionsProvider.notifier).addNewTransaction(newTransaction);
                createTransaction(newTransaction);
                Navigator.pop(context);
              });
            },
            tooltip: 'Create transaction',
            child: const Icon(Icons.add),
          ),
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: _currentViewIndex,
          onTabSelected: (index) => setState(() => _currentViewIndex = index),
          iconFontSize: 10,
          items: [
            BottomNavBarItem(icon: Icons.home_outlined, text: 'Home'),
            BottomNavBarItem(icon: Icons.account_balance_wallet_outlined, text: 'Wallet'),
            BottomNavBarItem(icon: Icons.rocket_launch_outlined, text: 'Goals'),
            BottomNavBarItem(icon: Icons.settings_outlined, text: 'Settings'),
          ],
        )
        // bottomNavigationBar: NavigationBar(
        //   // elevation: 5,
        //   // backgroundColor: Colors.blue.shade50,
        //   height: 58,
        //   labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        //   selectedIndex: _currentViewIndex,
        //   onDestinationSelected: (index) => setState(() => _currentViewIndex = index),
        //   destinations: const [
        //     NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
        //     NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Wallet'),
        //     NavigationDestination(icon: Icon(Icons.rocket_launch_outlined), label: 'Favorites'),
        //     NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        //   ],
        // ),
        );
  }
}
