import 'package:cloud_firestore/cloud_firestore.dart';

import 'user.dart';

void createUser() async {
  final userDoc = FirebaseFirestore.instance.collection('users').doc();

  final newUser = User(id: userDoc.id, name: 'Kuddus', age: 12, bday: DateTime.now());
  final json = newUser.toJson();
  try {
    userDoc.set(json);
    print('============ createUser ============');
  } catch (error) {
    print(error);
  }
}

Stream<List<User>> readUsers() {
  return FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}

Stream<User> readSingleUserStream(String id) {
  final userDoc = FirebaseFirestore.instance.collection('users').doc(id);
  final snapshot = userDoc.snapshots();
  return snapshot.map((doc) => User.fromJson(doc.data()!));
}

Future<User?> readSingleUser(String id) async {
  final userDoc = FirebaseFirestore.instance.collection('users').doc(id);
  final snapshot = await userDoc.get();
  if (snapshot.exists) {
    return User.fromJson(snapshot.data()!);
  }
  return null;
}

void updateSingleUser(String id, Map<String, dynamic> updatedData) async {
  final userDoc = FirebaseFirestore.instance.collection('users').doc(id);
  userDoc.update(updatedData);

  // userDoc.update({'name': 'new name'}); // update(): only update the given valeu

  //userDoc.set({'name': 'new name'}); //set() update and ovserride the ovther values

  // userDoc.update({
  //   'name.first': 'hasan', // update nested values
  //   'age': FieldValue.delete(), // delete this field
  // });
}

void deleteSingleUser(String id) async {
  final userDoc = FirebaseFirestore.instance.collection('users').doc(id);
  userDoc.delete(); // delete this user
}
