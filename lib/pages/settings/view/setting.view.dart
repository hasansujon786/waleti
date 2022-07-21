import 'package:flutter/material.dart';

import '../../../services/services.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  static const routeName = '/settings';
  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SettingView'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => AppAuth.signOut(),
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}
