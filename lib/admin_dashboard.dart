import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_role_provider.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final userRoleProvider = Provider.of<UserRoleProvider>(context);

    if (userRoleProvider.isLoading) {
      // Show a loading indicator while fetching the user role
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Ensure user is an admin
    if (userRoleProvider.role != 'admin') {
      return const Scaffold(
        body: Center(
          child: Text('Access Denied'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: const Icon(Icons.recent_actors, color: Colors.blue),
              title: const Text('View Recent Posts'),
              onTap: () {
                Navigator.pushNamed(context, '/admin/recent_posts');
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: const Icon(Icons.location_on, color: Colors.red),
              title: const Text('View Disaster Locations'),
              onTap: () {
                Navigator.pushNamed(context, '/admin/disaster_locations');
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: const Icon(Icons.lightbulb, color: Colors.green),
              title: const Text('Suggest Solutions'),
              onTap: () {
                Navigator.pushNamed(context, '/admin/suggest_solutions');
              },
            ),
          ),
        ],
      ),
    );
  }
}
