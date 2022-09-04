import 'package:flutter/material.dart';

import 'configs/configs.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true,
      title: Constants.appName,
      theme: AppTheme.light,
      routes: appRoutes,
    );
  }
}
