import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/controllers.dart';
import '../extensions/date_time_extension.dart';
import 'providers.dart';

final currentSelectedDayProvider = StateProvider<DateTime>((_) => DateTime.now());

final transactionsFromCurrentSelectedDayProvider = Provider<AsyncTransactionsRef>((ref) {
  final selectedDay = ref.watch(currentSelectedDayProvider);
  return ref
      .watch(allTransactionsFromSelectedWeek)
      .whenData((value) => value.where((item) => item.createdAt.isSameDayAs(selectedDay)).toList());
});
