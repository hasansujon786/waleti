import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppAuthWrapper extends StatelessWidget {
  final FirebaseAuth auth;
  final Widget loginView;
  final Widget authView;
  const AppAuthWrapper(
    this.auth, {
    Key? key,
    required this.loginView,
    required this.authView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something Went wrong'));
          } else if (snapshot.hasData) {
            return authView;
          }
          return loginView;
        },
      ),
    );
  }
}
