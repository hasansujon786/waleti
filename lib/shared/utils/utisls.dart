import 'package:cloud_firestore/cloud_firestore.dart';
export 'formatter.dart';

Future<bool> checkIfDocExists(DocumentReference<Map<String, dynamic>> docRef) async {
  try {
    // Get reference to Firestore collection
    var doc = await docRef.get();
    return doc.exists;
  } catch (e) {
    rethrow;
  }
}
