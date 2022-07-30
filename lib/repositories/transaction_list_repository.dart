import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../extensions/firebase_firestore_extension.dart';
import '../models/models.dart';
import '../providers/general_providers.dart';
import 'repositories.dart';

abstract class BaseTransactionListRepository {
  Future<List<MyTransaction>> retrieveItems({required String userId});
  Future<String> createItem({required String userId, required MyTransaction item});
  Future<void> updateItem({required String userId, required MyTransaction item});
  Future<void> deleteItem({required String userId, required String itemId});
}

final transactionListRepositoryProvider =
    Provider<TransactionListRepository>((ref) => TransactionListRepository(ref.read));

class TransactionListRepository implements BaseTransactionListRepository {
  final Reader _read;

  const TransactionListRepository(this._read);

  @override
  Future<List<MyTransaction>> retrieveItems({required String userId}) async {
    try {
      final snap = await _read(firebaseFirestoreProvider).transactionsRef(userId).get();
      return snap.docs.map((doc) => MyTransaction.fromJson(doc.data())).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> createItem({required String userId, required MyTransaction item}) async {
    try {
      final docRef = _read(firebaseFirestoreProvider).transactionsRef(userId).doc();
      item.id = docRef.id;
      docRef.set(item.toJson());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteItem({required String userId, required String itemId}) async {
    await _read(firebaseFirestoreProvider).transactionsRef(userId).doc(itemId).delete();
  }

  @override
  Future<void> updateItem({required String userId, required MyTransaction item}) async {
    try {
      final docRef = _read(firebaseFirestoreProvider).transactionsRef(userId).doc(item.id);
      await docRef.update(item.toJson());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}


// Stream<List<MyTransaction>> readTransactionsStream() {
//   String? _uid() => FirebaseAuth.instance.currentUser?.uid;

//   return FirebaseFirestore.instance
//       .collection('users')
//       .doc(_uid())
//       .collection('transactions')
//       .snapshots()
//       .map((snapshot) => snapshot.docs.map((doc) => MyTransaction.fromJson(doc.data())).toList());
// }
