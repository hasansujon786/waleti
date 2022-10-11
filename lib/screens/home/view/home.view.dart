import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

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
        top: false,
        child: CustomScrollView(
          slivers: <Widget>[
            const _HomeAppBar(),
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

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      titleSpacing: 12,
      centerTitle: true,
      leadingWidth: 46,
      // title: Text(Constants.appName, style: TextStyle(fontSize: 16)),
      expandedHeight: 300,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.teal,
      flexibleSpace: AccountCardHeader(bg: _bg),
      // flexibleSpace: const HomeDashboard(bg: _bg),
    );
  }
}

// actions: [
// IconButton(
//   onPressed: () => changeWeekBydiraction(ref, false),
//   icon: const Icon(Icons.chevron_left),
// ),
// IconButton(
//   onPressed: () => changeWeekBydiraction(ref, true),
//   icon: const Icon(Icons.chevron_right),
// ),
// IconButton(
//   iconSize: 22,
//   onPressed: () {
//     ref.read(weekViewControllerProvider.notifier).getThisWeek();
//     updateCurrentDateIdx(ref, DateTime.now());
//   },
//   icon: const Icon(Icons.calendar_today_outlined),
// ),
// const SizedBox(width: 2)
// ],
// void updateCurrentDateIdx(WidgetRef ref, DateTime selecTedDate) {
// ref.read(currentSelectedDayProvider.state).state = selecTedDate;
// }

// void changeWeekBydiraction(WidgetRef ref, bool isNext) {
// final currentWeek = ref.read(weekViewControllerProvider);

// if (isNext) {
// ref.read(weekViewControllerProvider.notifier).getNextWeek(currentWeek);
// } else {
// ref.read(weekViewControllerProvider.notifier).getPreviousWeek(currentWeek);
// }

// final selectedDay = ref.read(currentSelectedDayProvider);
// final updatedWeek = ref.read(weekViewControllerProvider);
// updateCurrentDateIdx(ref, updatedWeek[weekIndex(selectedDay)]);
// }
