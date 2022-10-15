import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/controllers.dart';
import '../models/models.dart';

final transactionListFilterProvider = StateProvider<TransactionListFilter>((_) => TransactionListFilter.all);

final allIncomeTransactionsProvider = Provider<AsyncTransactionsRef>(
  (ref) => _filterByType(ref, MyTransactionDataType.income),
);
final allExpenseTransactionsProvider = Provider<AsyncTransactionsRef>(
  (ref) => _filterByType(ref, MyTransactionDataType.expense),
);

AsyncTransactionsRef _filterByType(ProviderRef<AsyncTransactionsRef> ref, MyTransactionDataType filterBy) {
  return ref.watch(transactionListControllerProvider).whenData((items) {
    List<MyTransaction> filteredItems = items.where((item) => item.type == filterBy).toList();
    filteredItems.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return filteredItems;
  });
}

enum TransactionListFilter { all, expense, income }
