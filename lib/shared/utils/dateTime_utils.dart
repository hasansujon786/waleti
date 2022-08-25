import 'package:waleti/shared/utils/utisls.dart';

int todayIndexFromWeek() {
  final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final dayName = Formatters.dayName.format(DateTime.now());
  return days.indexWhere((element) => element == dayName);
}
