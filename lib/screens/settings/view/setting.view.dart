import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/controllers.dart';

class SettingView extends ConsumerWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user?.photoURL ?? ''),
                ),
                const SizedBox(height: 2),
                Text(user?.displayName ?? ''),
                const SizedBox(height: 2),
                Text(user?.email ?? ''),
                const SizedBox(height: 2),
                Text(user?.uid ?? ''),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
                  child: const Text('Sign out'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
