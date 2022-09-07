import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../repositories/repositories.dart';

typedef AsyncTransactionsRef = AsyncValue<List<MyTransaction>>;

final transactionListControllerProvider = StateNotifierProvider<TransactionListController, AsyncTransactionsRef>(
  (ref) => TransactionListController(ref.read),
);

class TransactionListController extends StateNotifier<AsyncTransactionsRef> {
  final Reader _read;
  TransactionListController(this._read) : super(const AsyncValue.loading()) {
    // if (_userId != null) { }
    retrieveItems();
  }

  Future<void> retrieveItems({bool isRefreshing = false}) async {
    if (isRefreshing) state = const AsyncValue.loading();
    try {
      final items = await _read(transactionListLocalRepositoryProvider).retrieveItems();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> addItem({required MyTransaction item}) async {
    try {
      await _read(transactionListLocalRepositoryProvider).createItem(item: item);
      state.whenData((items) => state = AsyncValue.data([item, ...items]));
    } catch (e) {
      state = AsyncValue.error(e);
      // _read(itemListExceptionProvider).state = e;
    }
  }

  Future<void> addMultipleItems({required List<MyTransaction> items}) async {
    try {
      await _read(transactionListLocalRepositoryProvider).createMultipleItem(items: items);
      state.whenData((oldItems) => state = AsyncValue.data([...items, ...oldItems]));
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> deleteItem({required MyTransaction item}) async {
    try {
      await _read(transactionListLocalRepositoryProvider).deleteItem(item: item);
      state.whenData((items) => state = AsyncValue.data(items..removeWhere((el) => el.id == item.id)));
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> updateItem({required MyTransaction updatedItem}) async {
    try {
      await _read(transactionListLocalRepositoryProvider).updateItem(item: updatedItem);
      state.whenData((items) {
        state = AsyncValue.data([
          for (final item in items)
            if (item.id == updatedItem.id) updatedItem else item
        ]);
      });
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> deleteAllTransactions() async {
    try {
      await _read(transactionListLocalRepositoryProvider).cleanDatabase();
      state = const AsyncValue.data([]);
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }
}
