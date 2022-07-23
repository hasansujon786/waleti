import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../repositories/repositories.dart';
import 'controllers.dart';

final transactionListControllerProvider =
    StateNotifierProvider<TransactionItemController, AsyncValue<List<MyTransaction>>>((ref) {
  final user = ref.watch(authControllerProvider);
  return TransactionItemController(ref.read, user?.uid);
});

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
      final items = await _read(transactionItemRepositoryProvider).retrieveItems(userId: _userId ?? '');
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      state = AsyncValue.error(e);
    }
  }
}
