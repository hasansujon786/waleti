import 'package:flutter/material.dart';

import 'firebase.dart' as fbase;
import 'user.dart';

class UserDetailsView extends StatefulWidget {
  const UserDetailsView({Key? key}) : super(key: key);

  static const routeName = '/dummy_users_details';
  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        actions: [
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            onPressed: () {
              fbase.deleteSingleUser(user.id);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: FutureBuilder(
        future: fbase.readSingleUser(user.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.hasData && snapshot.data == null) {
            return const Center(child: Text('no data'));
            // return ListView(children: users.map(buildUser).toList());
          }
          final userData = snapshot.data as User;
          // print(userData['id']);
          return SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 20),
                CircleAvatar(child: Text(userData.age.toString())),
                Text(userData.name),
                Text(userData.bday.toIso8601String()),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final newData = {'name': 'Sokina'};
                    fbase.updateSingleUser(user.id, newData);
                  },
                  child: const Text('Update User'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
