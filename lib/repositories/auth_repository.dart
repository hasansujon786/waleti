import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../providers/general_providers.dart';
import 'repositories.dart';

abstract class BaseAuthRepository {
  Stream<User?> get authStateChanges;
  Future<void> signInAnonymously();
  User? getCurrentUser();
  Future<void> signOut();
}

final _googleSignIn = GoogleSignIn();

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository(ref.read));

class AuthRepository implements BaseAuthRepository {
  final Reader _read;
  const AuthRepository(this._read);

  @override
  Stream<User?> get authStateChanges => _read(firebaseAuthProvider).authStateChanges();

  @override
  User? getCurrentUser() {
    try {
      return _read(firebaseAuthProvider).currentUser;
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> signInAnonymously() async {
    try {
      await _read(firebaseAuthProvider).signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _googleSignIn.disconnect();
      await _read(firebaseAuthProvider).signOut();
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final signedInUser = await _googleSignIn.signIn();
      if (signedInUser == null) {
        return null;
      }

      final googleAuth = await signedInUser.authentication;
      final userCredential = await _read(firebaseAuthProvider).signInWithCredential(GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      ));
      createIfNewUser(userCredential.user?.uid);
      return signedInUser;
    } catch (error) {
      print(error);
    }
    return null;
  }

  void createIfNewUser(String? uid) async {
    final userDoc = _read(firebaseFirestoreProvider).collection('users').doc(uid);
    var exists = await checkIfDocExists(userDoc);
    if (exists) return;

    // create new user doc
    userDoc.set({'createdAt': DateTime.now()});
  }
}

Future<bool> checkIfDocExists(DocumentReference<Map<String, dynamic>> docRef) async {
  try {
    // Get reference to Firestore collection
    var doc = await docRef.get();
    return doc.exists;
  } catch (e) {
    rethrow;
  }
}
