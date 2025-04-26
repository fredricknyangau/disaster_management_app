import 'package:flutter/material.dart';

class PublicQueries extends StatelessWidget {
  const PublicQueries({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Public Queries')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.post_add, color: Colors.blue),
                title: const Text('Post New Query'),
                onTap: () {
                  Navigator.pushNamed(context, '/public/post_query');
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.visibility, color: Colors.green),
                title: const Text('View Responses'),
                onTap: () {
                  Navigator.pushNamed(context, '/public/view_responses');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
