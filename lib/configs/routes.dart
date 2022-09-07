import 'package:flutter/material.dart';
import '../screens/screens.dart';
import '../dummy/user/user.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  '/': (ctx) => const RootNavigation(),
  TransactionDetailsView.routeName: (ctx) => TransactionDetailsView(ctx),
  UsersView.routeName: (ctx) => const UsersView(title: 'All Users'),
  UserDetailsView.routeName: (ctx) => const UserDetailsView(),
};
