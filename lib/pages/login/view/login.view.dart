import 'package:flutter/material.dart';

import '../../../services/services.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => AppAuth.signInWithGoogle(),
          child: const Text('Signin with Google'),
        ),
      ),
    );
  }
}
