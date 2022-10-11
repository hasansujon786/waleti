import '../shared/utils/utisls.dart';

extension DateUtils on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.day == day && tomorrow.month == month && tomorrow.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day && yesterday.month == month && yesterday.year == year;
  }

  bool isSameDayAs(DateTime dateToCheck) {
    return day == dateToCheck.day && month == dateToCheck.month && year == dateToCheck.year;
  }

  String relateiveDate() {
    final date = this;
    return date.isToday
        ? 'Today'
        : date.isYesterday
            ? 'Yesterday'
            : Formatters.monthDayYear.format(date);
  }
}


    // var days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    // // var now = DateTime.now();
    // var now = DateTime.now().subtract(const Duration(days: 2));
    // var weedDay = DateFormat.E().format(now);
    // var curDayIndex = days.indexWhere((element) => element == weedDay);
    // // print(curDayIndex);
    // var rightSideIndex = 6 - curDayIndex;
    //       var isPrevAndTodayIndex = index >= rightSideIndex;
