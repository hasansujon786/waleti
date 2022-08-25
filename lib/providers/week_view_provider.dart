import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:waleti/controllers/controllers.dart';
import 'package:waleti/models/models.dart';
import 'package:waleti/shared/utils/utisls.dart';
import './providers.dart';

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
  (ref) => ref.watch(allExpanseTransactionsProvider).whenData(_filterByWeek),
);

final thisWeekAllIncomeTransactions = Provider<AsyncTransactionsRef>(
  (ref) => ref.watch(allIncomeTransactionsProvider).whenData(_filterByWeek),
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

List<MyTransaction> _filterByWeek(List<MyTransaction> value) =>
    value.where((e) => e.createdAt.isAfter(DateTime.now().subtract(Duration(days: todayIndexFromWeek() + 1)))).toList();
