import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../services.dart';

final _googleSignIn = GoogleSignIn();
final _auth = FirebaseAuth.instance;

class AppAuth {
  static Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final signedInUser = await _googleSignIn.signIn();
      if (signedInUser == null) {
        return null;
      }

      final googleAuth = await signedInUser.authentication;
      final userCredential = await _auth.signInWithCredential(GoogleAuthProvider.credential(
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

  static signOut() async {
    await _googleSignIn.disconnect();
    _auth.signOut();
  }

  static User? get user {
    return _auth.currentUser;
  }
}
