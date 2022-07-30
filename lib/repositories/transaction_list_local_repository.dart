import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/models.dart';

abstract class BaseTransactionListRepository {
  Future<List<MyTransaction>> retrieveItems();
  Future<int> createItem({required MyTransaction item});
  Future<void> updateItem({required MyTransaction item});
  Future<void> deleteItem({required MyTransaction item});
  Future<void> cleanDatabase();
}

final transactionListLocalRepositoryProvider = Provider<TransactionListLocalRepository>((ref) {
  final box = Boxes.transaction();
  return TransactionListLocalRepository(ref.read, box);
});

class TransactionListLocalRepository implements BaseTransactionListRepository {
  final Reader _read;
  final Box<MyTransaction> _box;
  const TransactionListLocalRepository(this._read, this._box);

  @override
  Future<List<MyTransaction>> retrieveItems() async {
    try {
      return _box.values.toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> createItem({required MyTransaction item}) async {
    try {
      return await _box.add(item);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteItem({required MyTransaction item}) async {
    try {
      return _box.delete(item.key);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateItem({required MyTransaction item}) async {
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
