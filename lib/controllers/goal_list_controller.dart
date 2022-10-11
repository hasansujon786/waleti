import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../repositories/repositories.dart';

typedef AsyncGoalRef = AsyncValue<List<Goal>>;

final goalListControllerProvider = StateNotifierProvider<GoalListController, AsyncGoalRef>(
  (ref) => GoalListController(ref.read),
);

class GoalListController extends StateNotifier<AsyncGoalRef> {
  final Reader _read;
  GoalListController(this._read) : super(const AsyncValue.loading()) {
    retrieveItems();
  }

  Future<void> retrieveItems({bool isRefreshing = false}) async {
    if (isRefreshing) state = const AsyncValue.loading();
    try {
      final items = await _read(goalRepositoryProvider).retrieveItems();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> addItem({required Goal item}) async {
    try {
      await _read(goalRepositoryProvider).createItem(item: item);
      state.whenData((items) => state = AsyncValue.data([item, ...items]));
    } catch (e) {
      state = AsyncValue.error(e);
      // _read(itemListExceptionProvider).state = e;
    }
  }

  Future<void> addMultipleItems({required List<Goal> items}) async {
    try {
      await _read(goalRepositoryProvider).createMultipleItem(items: items);
      state.whenData((oldItems) => state = AsyncValue.data([...items, ...oldItems]));
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> deleteItem({required Goal item}) async {
    try {
      await _read(goalRepositoryProvider).deleteItem(item: item);
      state.whenData((items) => state = AsyncValue.data(items..removeWhere((el) => el.id == item.id)));
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> updateItem({required Goal updatedItem}) async {
    try {
      await _read(goalRepositoryProvider).updateItem(item: updatedItem);
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

  Future<void> deleteAllGoals() async {
    try {
      await _read(goalRepositoryProvider).cleanDatabase();
      state = const AsyncValue.data([]);
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }
}
