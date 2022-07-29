import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../repositories/repositories.dart';
import 'controllers.dart';

enum TransactionListFilter { all, expanse, income }

final transactionListFilterProvider = StateProvider<TransactionListFilter>((_) => TransactionListFilter.expanse);

final filteredTransactionsListProvider = Provider<AsyncValue<List<MyTransaction>>>((ref) {
  final allTransactions = ref.watch(transactionListControllerProvider);
  final filterState = ref.watch(transactionListFilterProvider);

  return allTransactions.whenData((items) {
    switch (filterState) {
      case TransactionListFilter.expanse:
        return items.where((item) => item.type == MyTransactionDataType.expanse).toList();
      case TransactionListFilter.income:
        return items.where((item) => item.type == MyTransactionDataType.income).toList();
      case TransactionListFilter.all:
        return items;
      default:
        return [];
    }
  });
});

final transactionListControllerProvider =
    StateNotifierProvider<TransactionListController, AsyncValue<List<MyTransaction>>>(
  (ref) {
    final user = ref.watch(authControllerProvider);
    return TransactionListController(ref.read, user?.uid);
  },
);

class TransactionListController extends StateNotifier<AsyncValue<List<MyTransaction>>> {
  final Reader _read;
  final String? _userId;

  TransactionListController(this._read, this._userId) : super(const AsyncValue.loading()) {
    if (_userId != null) {
      retrieveItems();
    }
  }

  Future<void> retrieveItems({bool isRefreshing = false}) async {
    if (isRefreshing) state = const AsyncValue.loading();
    try {
      final items = await _read(transactionListRepositoryProvider).retrieveItems(userId: _userId!);
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> addItem({required MyTransaction item}) async {
    try {
      final itemId = await _read(transactionListRepositoryProvider).createItem(
        userId: _userId!,
        item: item,
      );

      item.id = itemId;
      state.whenData((items) => state = AsyncValue.data(items..add(item)));
    } on CustomException catch (e) {
      print(e);
      // _read(itemListExceptionProvider).state = e;
    }
  }

  Future<void> deleteItem({required String itemId}) async {
    try {
      await _read(transactionListRepositoryProvider).deleteItem(userId: _userId!, itemId: itemId);

      state.whenData((items) => state = AsyncValue.data(items..removeWhere((item) => item.id == itemId)));
    } on CustomException catch (e) {
      print(e);
      // _read(itemListExceptionProvider).state = e;
    }
  }

  Future<void> updateItem({required MyTransaction updatedItem}) async {
    try {
      await _read(transactionListRepositoryProvider).updateItem(userId: _userId!, item: updatedItem);
      state.whenData((items) {
        state = AsyncValue.data([
          for (final item in items)
            if (item.id == updatedItem.id) updatedItem else item
        ]);
      });
    } on CustomException catch (e) {
      print(e);
      // _read(itemListExceptionProvider).state = e;
    }
  }
}

Stream<List<MyTransaction>> readTransactionsStream() {
  String? _uid() => FirebaseAuth.instance.currentUser?.uid;

  return FirebaseFirestore.instance
      .collection('users')
      .doc(_uid())
      .collection('transactions')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => MyTransaction.fromJson(doc.data())).toList());
}
