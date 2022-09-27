import 'package:intl/intl.dart';

class Formatters {
  static final currency = NumberFormat('##0.0#', 'en_US');
  static final monthDayYear = DateFormat().add_yMMMd();
  static final monthDay = DateFormat().add_MMMd();
  static final monthDayFull = DateFormat().add_MMMMd();
  static final dayName = DateFormat.E();
  static final dayNameFull = DateFormat.EEEE();
}
