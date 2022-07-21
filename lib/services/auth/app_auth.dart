import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      _auth.signInWithCredential(GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      ));
      return signedInUser;
    } catch (error) {
      print(error.toString());
    }
    return null;
  }

  static signOut() async {
    await _googleSignIn.disconnect();
    _auth.signOut();
  }

  User? get user {
    return _auth.currentUser;
  }
}
