import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/configs.dart';
import '../../../controllers/controllers.dart';
import '../../../extensions/date_time_extension.dart';
import '../../../providers/providers.dart';
import '../../../shared/utils/utisls.dart';
import '../widgets/widgets.dart';

// const _bg = Colors.blue;
// const _bg = Color(0xffF8FAF7);
const _bg = Palette.primary;

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
            const HomeAppBar(),
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

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return SliverAppBar(
      title: buildCurrentDate(context, ref),
      actions: [
        IconButton(
          onPressed: () => changeWeekBydiraction(ref, false),
          icon: const Icon(Icons.chevron_left),
        ),
        IconButton(
          onPressed: () => changeWeekBydiraction(ref, true),
          icon: const Icon(Icons.chevron_right),
        ),
        IconButton(
          onPressed: () {
            ref.read(weekViewControllerProvider.notifier).getThisWeek();
            updateCurrentDateIdx(ref, DateTime.now());
          },
          icon: const Icon(Icons.calendar_today_outlined),
        ),
        const SizedBox(width: 2)
      ],
      titleSpacing: 12,
      centerTitle: false,
      leadingWidth: 46,
      // leading: IconButton(
      //   iconSize: 22,
      //   onPressed: () {},
      //   icon: const Icon(Icons.search),
      // ),
      expandedHeight: 320,
      pinned: true,
      stretch: true,
      flexibleSpace: const HomeDashboard(bg: _bg),
    );
  }

  Widget buildCurrentDate(BuildContext context, WidgetRef ref) {
    final date = ref.watch(currentSelectedDayProvider);
    final title = date.isToday
        ? 'TODAY'
        : date.isYesterday
            ? 'YESTERDAY'
            : Formatters.monthDay.format(date).toUpperCase();

    final subtitle = date.isToday || date.isYesterday ? Formatters.monthDay : Formatters.dayNameFull;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle.format(date),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.grey.shade400),
        ),
      ],
    );
  }

  void updateCurrentDateIdx(WidgetRef ref, DateTime selecTedDate) {
    ref.read(currentSelectedDayProvider.state).state = selecTedDate;
  }

  void changeWeekBydiraction(WidgetRef ref, bool isNext) {
    final currentWeek = ref.read(weekViewControllerProvider);

    if (isNext) {
      ref.read(weekViewControllerProvider.notifier).getNextWeek(currentWeek);
    } else {
      ref.read(weekViewControllerProvider.notifier).getPreviousWeek(currentWeek);
    }

    final selectedDay = ref.read(currentSelectedDayProvider);
    final updatedWeek = ref.read(weekViewControllerProvider);
    updateCurrentDateIdx(ref, updatedWeek[weekIndex(selectedDay)]);
  }
}
