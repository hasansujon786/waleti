import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'configs/configs.dart';
import 'pages/pages.dart';
import 'shared/ui/ui.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true,
      title: Constants.appName,
      theme: AppTheme.light,
      home: const RootNavigation(),
      routes: appRoutes,
      // home: AppAuthWrapper(
      //   FirebaseAuth.instance,
      //   loginView: const LoginView(),
      //   authView: const RootNavigation(),
      // ),
    );
  }
}
