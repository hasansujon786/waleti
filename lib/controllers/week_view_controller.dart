import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/utils/utisls.dart';

final weekViewControllerProvider =
    StateNotifierProvider<WeekViewController, List<DateTime>>((ref) => WeekViewController());

class WeekViewController extends StateNotifier<List<DateTime>> {
  WeekViewController() : super([]) {
    getThisWeek();
  }

  void getThisWeek() {
    state = getWeekDays(DateTime.now());
  }

  void getPreviousWeek(List<DateTime> from) {
    final firstDayOfPrevWeek = from[0].subtract(const Duration(days: 7));
    state = getWeekDays(firstDayOfPrevWeek);
  }

  void getNextWeek(List<DateTime> from) {
    final firstDayOfNextWeek = from[0].add(const Duration(days: 7));
    state = getWeekDays(firstDayOfNextWeek);
  }

  static List<DateTime> getWeekDays(DateTime date) {
    DateTime firstDayOfTheweek = date.subtract(Duration(days: weekIndex(date)));
    return List.generate(7, (i) => firstDayOfTheweek.add(Duration(days: i))).toList();
  }
}
