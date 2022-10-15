import 'package:flutter_riverpod/flutter_riverpod.dart';

import './providers.dart';
import '../controllers/controllers.dart';
import '../extensions/date_time_extension.dart';
import '../models/models.dart';

// transactions filtered by week
final allTransactionsFromSelectedWeek = Provider<AsyncTransactionsRef>(
  (ref) => ref
      .watch(transactionListControllerProvider)
      .whenData((items) => _filterByWeek(items, ref.watch(weekViewControllerProvider))),
);
final allExpenseTransactionsFromSelectedWeek = Provider<AsyncTransactionsRef>(
  (ref) => ref
      .watch(allExpenseTransactionsProvider)
      .whenData((items) => _filterByWeek(items, ref.watch(weekViewControllerProvider))),
);
final allIncomeTransactionsFromSelectedWeek = Provider<AsyncTransactionsRef>(
  (ref) => ref
      .watch(allIncomeTransactionsProvider)
      .whenData((items) => _filterByWeek(items, ref.watch(weekViewControllerProvider))),
);

// total transaction amount filtered by week
final totalExpenceOfSelectedWeek = Provider<AsyncValue<double>>(
  (ref) => ref.watch(allExpenseTransactionsFromSelectedWeek).whenData(_calculateTotalAmount),
);
final totalIncomeOfSelectedWeek = Provider<AsyncValue<double>>(
  (ref) => ref.watch(allIncomeTransactionsFromSelectedWeek).whenData(_calculateTotalAmount),
);

// ================================================
// => utils
// ================================================
double _calculateTotalAmount(List<MyTransaction> value) =>
    value.fold(0, (previousValue, element) => element.amount + previousValue);

List<MyTransaction> _filterByWeek(List<MyTransaction> value, List<DateTime> currentSelectedWeek) {
  final from = currentSelectedWeek[0];
  final to = currentSelectedWeek[currentSelectedWeek.length - 1];

  var items = value.where((e) {
    final sameDay = e.createdAt.isSameDayAs(to) || e.createdAt.isSameDayAs(from);
    final isAfter = e.createdAt.isAfter(from);
    final isBefore = e.createdAt.isBefore(to);
    return isAfter && isBefore || sameDay;
  }).toList();
  items.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  return items;
}

// final filteredTransactionsByWeek = Provider<AsyncTransactionsRef>((ref) {
//   final filterState = ref.watch(transactionListFilterProvider);
//   switch (filterState) {
//     case TransactionListFilter.expense:
//       return ref.watch(expenseTransactionsFromSelectedWeek);
//     case TransactionListFilter.income:
//       return ref.watch(incomeTransactionsFromSelectedWeek);
//     case TransactionListFilter.all:
//     default:
//       return ref.watch(allTransactionsFromSelectedWeek);
//   }
// });

