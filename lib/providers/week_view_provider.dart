import 'package:flutter_riverpod/flutter_riverpod.dart';

import './providers.dart';
import '../controllers/controllers.dart';
import '../extensions/date_time_extension.dart';
import '../models/models.dart';

final filteredTransactionsByWeek = Provider<AsyncTransactionsRef>((ref) {
  final filterState = ref.watch(transactionListFilterProvider);
  switch (filterState) {
    case TransactionListFilter.expanse:
      return ref.watch(expanseTransactionsFromSelectedWeek);
    case TransactionListFilter.income:
      return ref.watch(incomeTransactionsFromSelectedWeek);
    case TransactionListFilter.all:
    default:
      return ref.watch(transactionsFromSelectedWeek);
  }
});

final transactionsFromSelectedWeek = Provider<AsyncTransactionsRef>(
  (ref) => ref
      .watch(transactionListControllerProvider)
      .whenData((value) => _filterByWeek(value, ref.watch(weekViewControllerProvider))),
);

final expanseTransactionsFromSelectedWeek = Provider<AsyncTransactionsRef>(
  (ref) => ref
      .watch(allExpanseTransactionsProvider)
      .whenData((value) => _filterByWeek(value, ref.watch(weekViewControllerProvider))),
);

final incomeTransactionsFromSelectedWeek = Provider<AsyncTransactionsRef>(
  (ref) => ref
      .watch(allIncomeTransactionsProvider)
      .whenData((value) => _filterByWeek(value, ref.watch(weekViewControllerProvider))),
);

final totalExpenceOfSelectedWeek = Provider<AsyncValue<double>>(
  (ref) => ref.watch(expanseTransactionsFromSelectedWeek).whenData(_calculateTotalAmount),
);

final totalIncomeOfSelectedWeek = Provider<AsyncValue<double>>(
  (ref) => ref.watch(incomeTransactionsFromSelectedWeek).whenData(_calculateTotalAmount),
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
