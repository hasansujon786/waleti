import 'package:flutter/material.dart';
import '../pages/pages.dart';
import '../dummy/user/user.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  '/': (ctx) => const RootNavigation(),
  UsersView.routeName: (ctx) => const UsersView(title: 'All Users'),
  UserDetailsView.routeName: (ctx) => const UserDetailsView(),
  TransactionDetailsView.routeName: (ctx) => const TransactionDetailsView(title: 'Expanse Details'),
};
