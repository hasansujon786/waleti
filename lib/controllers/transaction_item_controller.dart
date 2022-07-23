import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../repositories/repositories.dart';
import 'controllers.dart';

final transactionListControllerProvider =
    StateNotifierProvider<TransactionItemController, AsyncValue<List<MyTransaction>>>(
  (ref) {
    final user = ref.watch(authControllerProvider);
    return TransactionItemController(ref.read, user?.uid);
  },
);

class TransactionItemController extends StateNotifier<AsyncValue<List<MyTransaction>>> {
  final Reader _read;
  final String? _userId;

  TransactionItemController(this._read, this._userId) : super(const AsyncValue.loading()) {
    if (_userId != null) {
      retrieveItems();
    }
  }

  Future<void> retrieveItems({bool isRefreshing = false}) async {
    if (isRefreshing) state = const AsyncValue.loading();
    try {
      final items = await _read(transactionItemRepositoryProvider).retrieveItems(userId: _userId!);
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> addItem({required MyTransaction item}) async {
    try {
      final itemId = await _read(transactionItemRepositoryProvider).createItem(
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
      await _read(transactionItemRepositoryProvider).deleteItem(userId: _userId!, itemId: itemId);

      state.whenData((items) => state = AsyncValue.data(items..removeWhere((item) => item.id == itemId)));
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
