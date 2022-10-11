import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:waleti/models/models.dart';


final goalRepositoryProvider = Provider<GoalsRepository>((ref) {
  final box = Boxes.goal();
  return GoalsRepository(ref.read, box);
});

abstract class BaseGoalsRepository {
  Future<List<Goal>> retrieveItems();
  Future<int> createItem({required Goal item});
  Future<void> updateItem({required Goal item});
  Future<void> deleteItem({required Goal item});
  Future<Iterable<int>> createMultipleItem({required List<Goal> items});
  Future<void> cleanDatabase();
}


class GoalsRepository implements BaseGoalsRepository {
  final Reader _read;
  final Box<Goal> _box;
  const GoalsRepository(this._read, this._box);

  @override
  Future<List<Goal>> retrieveItems() async {
    try {
      return _box.values.toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> createItem({required Goal item}) async {
    try {
      return await _box.add(item);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Iterable<int>> createMultipleItem({required List<Goal> items}) async {
    try {
      return await _box.addAll(items);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteItem({required Goal item}) async {
    try {
      return _box.delete(item.key);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateItem({required Goal item}) async {
    try {
      _box.put(item.key, item);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> cleanDatabase() {
    return _box.clear();
  }
}
