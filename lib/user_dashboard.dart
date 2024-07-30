import 'package:flutter/material.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.question_answer, color: Colors.blue),
                title: const Text('View and Post Queries'),
                onTap: () {
                  Navigator.pushNamed(context, '/user/queries');
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.speaker_notes, color: Colors.green),
                title: const Text('Receive Solutions'),
                onTap: () {
                  Navigator.pushNamed(context, '/user/solutions');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
