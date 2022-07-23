import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseFirestoreX on FirebaseFirestore {
// QuerySnapshot<Map<String, dynamic>>
  CollectionReference<Map<String, dynamic>> transactionsRef(String userId) =>
      collection('users').doc(userId).collection('transactions');
}
