import 'package:waleti/shared/utils/utisls.dart';

int weekIndex(DateTime date) {
  final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  return days.indexWhere((e) => e == Formatters.dayName.format(date));
}

List<String> convertDates(List<DateTime> dates) {
  return dates.map((e) => Formatters.monthDay.format(e)).toList();
}
