import 'package:intl/intl.dart';

class Formatters {
  static final currency = NumberFormat('##0.0#', 'en_US');
  static final monthDayYear = DateFormat().add_yMMMd();
}
