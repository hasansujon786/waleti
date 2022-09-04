import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/controllers.dart';

class LoginView extends ConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(authControllerProvider.notifier).signIn();
          },
          child: const Text('Signin with Google'),
        ),
      ),
    );
  }
}
