import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${user?.email ?? "N/A"}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            // Add more user details here if needed
          ],
        ),
      ),
    );
  }
}
