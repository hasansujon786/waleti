import 'package:flutter/material.dart';

import '../../../services/services.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AppAuth.user;
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
                  onPressed: () => AppAuth.signOut(),
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
