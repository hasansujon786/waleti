import 'package:flutter_riverpod/flutter_riverpod.dart';

import './providers.dart';
import '../controllers/controllers.dart';
import '../extensions/date_time_extension.dart';
import '../models/models.dart';

final currentTransactionsFilterByWeek = Provider<AsyncTransactionsRef>((ref) {
  final filterState = ref.watch(transactionListFilterProvider);
  switch (filterState) {
    case TransactionListFilter.expanse:
      return ref.watch(thisWeekAllExpenceTransactions);
    case TransactionListFilter.income:
      return ref.watch(thisWeekAllIncomeTransactions);
    case TransactionListFilter.all:
    default:
      return ref.watch(transactionListControllerProvider);
  }
});

final thisWeekAllExpenceTransactions = Provider<AsyncTransactionsRef>(
  (ref) => ref
      .watch(allExpanseTransactionsProvider)
      .whenData((value) => _filterByWeek(value, ref.watch(weekViewControllerProvider))),
);

final thisWeekAllIncomeTransactions = Provider<AsyncTransactionsRef>(
  (ref) => ref
      .watch(allIncomeTransactionsProvider)
      .whenData((value) => _filterByWeek(value, ref.watch(weekViewControllerProvider))),
);

final thisWeekTotalExpenceAmount = Provider<AsyncValue<double>>(
  (ref) => ref.watch(thisWeekAllExpenceTransactions).whenData(_calculateTotalAmount),
);

final thisWeekTotalIncomeAmount = Provider<AsyncValue<double>>(
  (ref) => ref.watch(thisWeekAllIncomeTransactions).whenData(_calculateTotalAmount),
);

// ================================================
// => utils
// ================================================
double _calculateTotalAmount(List<MyTransaction> value) =>
    value.fold(0, (previousValue, element) => element.amount + previousValue);

List<MyTransaction> _filterByWeek(List<MyTransaction> value, List<DateTime> currentSelectedWeek) {
  final from = currentSelectedWeek[0];
  final to = currentSelectedWeek[currentSelectedWeek.length - 1];

  return value.where((e) {
    final sameDay = e.createdAt.isSameDayAs(to) || e.createdAt.isSameDayAs(from);
    final isAfter = e.createdAt.isAfter(from);
    final isBefore = e.createdAt.isBefore(to);
    return isAfter && isBefore || sameDay;
  }).toList();
  // print('${e.createdAt.day} isAfter ${from.day} $isAfter | ${e.createdAt.day} isBefore ${to.day} $isBefore');
  // print('sameDay $sameDay');
  // print('all => ${convertDates(value.map((e) => e.createdAt).toList())}');
  // print('filterd => ${convertDates(foo.map((e) => e.createdAt).toList())}');
}
