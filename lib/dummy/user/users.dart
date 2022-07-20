import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'firebase.dart' as fbase;
import 'user.dart';

class UsersView extends StatefulWidget {
  final String title;
  const UsersView({Key? key, required this.title}) : super(key: key);

  static const routeName = '/dummy_users';

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const ElevatedButton(onPressed: fbase.createUser, child: Text('Create user')),
            Expanded(
              child: StreamBuilder(
                stream: fbase.readUsers(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    final List<User> users = snapshot.data;
                    return ListView(children: users.map(buildUser).toList());
                  }
                  return const Center(child: Text('no data'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUser(User user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Colors.grey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onTap: () {
          Navigator.pushNamed(context, UserDetailsView.routeName, arguments: user);
        },
        leading: CircleAvatar(child: Text(user.age.toString())),
        title: Text(user.name),
        subtitle: Text(user.bday.toIso8601String()),
        trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
      ),
    );
  }
}

class User {
  final String id;
  final String name;
  final int age;
  final DateTime bday;
  const User({
    this.id = '',
    required this.name,
    required this.age,
    required this.bday,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'bday': bday,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        bday: (json['bday'] as Timestamp).toDate(),
      );
}
