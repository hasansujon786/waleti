import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/models.dart';
import '../../services/services.dart';
import '../../shared/utils/utisls.dart';

String? _uid() => AppAuth.user?.uid;

void createIfNewUser(String? uid) async {
  final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
  var exists = await checkIfDocExists(userDoc);
  if (exists) return;

  // create new user doc
  userDoc.set({'createdAt': DateTime.now()});
}

DocumentReference<Map<String, dynamic>> db() {
  final userDoc = FirebaseFirestore.instance.collection('users').doc(_uid());
  return userDoc;
}

Future<MyTransaction?> createTransaction(MyTransaction newTx) async {
  final txDoc = db().collection('transactions').doc();

  newTx.id = txDoc.id;
  final json = newTx.toJson();

  try {
    txDoc.set(json);
    return newTx;
  } catch (error) {
    print(error);
  }
  return null;
}

Stream<List<MyTransaction>> readTransactions() {
  return db()
      .collection('transactions')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => MyTransaction.fromJson(doc.data())).toList());
}

void deleteSingleTransaction(String transactionId) async {
  final txDoc = db().collection('transactions').doc(transactionId);
  txDoc.delete();
}
