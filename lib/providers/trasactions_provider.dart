import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/controllers.dart';
import '../extensions/date_time_extension.dart';
import '../models/models.dart';
import 'providers.dart';

final currentSelectedDayProvider = StateProvider<DateTime>((_) => DateTime.now());
final transactionListFilterProvider = StateProvider<TransactionListFilter>((_) => TransactionListFilter.expanse);

final transactionsFromCurrentSelectedDayProvider = Provider<AsyncTransactionsRef>((ref) {
  final selectedDay = ref.watch(currentSelectedDayProvider);
  return ref
      .watch(currentTransactionsFilterByWeek)
      .whenData((value) => value.where((item) => item.createdAt.isSameDayAs(selectedDay)).toList());
});

final allIncomeTransactionsProvider = Provider<AsyncTransactionsRef>(
  (ref) => _filterByType(ref, MyTransactionDataType.income),
);
final allExpanseTransactionsProvider = Provider<AsyncTransactionsRef>(
  (ref) => _filterByType(ref, MyTransactionDataType.expanse),
);

AsyncTransactionsRef _filterByType(ProviderRef<AsyncTransactionsRef> ref, MyTransactionDataType filterBy) {
  return ref.watch(transactionListControllerProvider).whenData((items) {
    List<MyTransaction> filteredItems = items.where((item) => item.type == filterBy).toList();
    filteredItems.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return filteredItems;
  });
}

enum TransactionListFilter { all, expanse, income }
