import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/models.dart';

const _uid = '4Up3gxwsLUbajetO9KA1';

DocumentReference<Map<String, dynamic>> db(String uid) {
  return FirebaseFirestore.instance.collection('users').doc(uid);
}

Future<MyTransaction?> createTransaction(MyTransaction newTx) async {
  final txDoc = db(_uid).collection('transactions').doc();

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
  return db(_uid)
      .collection('transactions')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => MyTransaction.fromJson(doc.data())).toList());
}

void deleteSingleTransaction(String transactionId) async {
  final txDoc = db(_uid).collection('transactions').doc(transactionId);
  txDoc.delete();
}
