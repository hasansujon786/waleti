import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';

final transactionsProvider = StateNotifierProvider<TransactionsProvider, List<MyTransaction>>((ref) {
  return TransactionsProvider(ref, demoTransactions);
});

class TransactionsProvider extends StateNotifier<List<MyTransaction>> {
  final Ref ref;
  TransactionsProvider(this.ref, [List<MyTransaction>? state]) : super(state ?? <MyTransaction>[]);

  void addNewTransaction(MyTransaction newTransaction) {
    state = [newTransaction, ...state];
  }

  void removeOneItem({required String id}) {
    // var foundIndex = box.values.toList().indexWhere((element) => element.id == id);
    // if (foundIndex > -1) {
    //   box.deleteAt(foundIndex);
    // }
    // state = state.where((element) => element.id != id).toList();
  }

  void clearAllItems() {
    state = [];
  }

  void removeMultiple(Iterable<int> list) {
    // var keys = list.map((e) => box.keyAt(e));
    // box.deleteAll(keys);
    // state = box.values.toList();
  }
}
