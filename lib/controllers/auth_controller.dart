import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/repositories.dart';

// (ref) => AuthController(ref.read)..appStarted(),
final authControllerProvider = StateNotifierProvider<AuthController, User?>((ref) => AuthController(ref.read));

class AuthController extends StateNotifier<User?> {
  final Reader _read;
  // save the running subscription to delte on dispose
  StreamSubscription<User?>? _authStateChangesSubscription;

  AuthController(this._read) : super(null) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription = _read(authRepositoryProvider).authStateChanges.listen((user) => state = user);
  }

  void appStarted() async {
    // final user = _read(authRepositoryProvider).getCurrentUser();
    // if (user == null) {
    //   await _read(authRepositoryProvider).signInAnonymously();
    // }
  }

  void signIn() async {
    await _read(authRepositoryProvider).signInWithGoogle();
  }

  void signOut() async {
    await _read(authRepositoryProvider).signOut();
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }
}
