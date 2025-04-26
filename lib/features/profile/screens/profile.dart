import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('View Profile Details'),
            onTap: () {
              Navigator.pushNamed(context, '/profile/view');
            },
          ),
          ListTile(
            title: const Text('Edit Profile Information'),
            onTap: () {
              Navigator.pushNamed(context, '/profile/edit');
            },
          ),
          ListTile(
            title: const Text('Change Password'),
            onTap: () {
              Navigator.pushNamed(context, '/profile/change_password');
            },
          ),
        ],
      ),
    );
  }
}
