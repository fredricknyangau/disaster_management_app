import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({Key? key}) : super(key: key);

  // Function to fetch user data from Firestore
  Future<Map<String, String>> _fetchUserData(String userId) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      return {
        'fullName': userDoc['fullName'] ?? 'Unknown',
        'role': userDoc['role'] ?? 'Unknown',
        'location': userDoc['location'] ?? 'Unknown',
      };
    } else {
      throw Exception('User not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    // user ID from FirebaseAuth
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    // Check if user is logged in
    if (userId == 'null') {
      return const Scaffold(
        body: Center(
          child: Text('Please log in to view your dashboard.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, String>>(
        future: _fetchUserData(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            final userData = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pass real data to ProfileOverview
                  ProfileOverview(
                    fullName: userData['fullName']!,
                    role: userData['role']!,
                    location: userData['location']!,
                  ),
                  const SizedBox(height: 20),
                  const SectionTitle(title: 'Disaster Alerts'),
                  const SizedBox(height: 10),
                  const DisasterAlerts(),
                  const SizedBox(height: 20),
                  const SectionTitle(title: 'Recent Updates'),
                  const SizedBox(height: 10),
                  const RecentUpdates(),
                  const SizedBox(height: 20),
                  const SectionTitle(title: 'Actions'),
                  const SizedBox(height: 10),
                  const UserActions(),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('No user data found'),
            );
          }
        },
      ),
    );
  }
}

class ProfileOverview extends StatelessWidget {
  final String fullName;
  final String role;
  final String location;

  const ProfileOverview({
    Key? key,
    required this.fullName,
    required this.role,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fullName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Role: $role',
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 4),
              Text(
                'Location: $location',
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }
}

class DisasterAlerts extends StatelessWidget {
  const DisasterAlerts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final alerts = [
      {
        'title': 'Flood Alert',
        'description': 'Heavy rains expected in Kisumu.',
        'color': Colors.red,
      },
      {
        'title': 'Drought Alert',
        'description': 'Water scarcity in Turkana.',
        'color': Colors.orange,
      },
      {
        'title': 'Earthquake Alert',
        'description': 'Tremors felt in Nakuru.',
        'color': Colors.purple,
      },
    ];

    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: alerts
            .map(
              (alert) => AlertCard(
                title: alert['title'] as String,
                description: alert['description'] as String,
                color: alert['color'] as Color,
              ),
            )
            .toList(),
      ),
    );
  }
}

class AlertCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;

  const AlertCard({
    Key? key,
    required this.title,
    required this.description,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class RecentUpdates extends StatelessWidget {
  const RecentUpdates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final updates = [
      {
        'title': 'Community Cleanup',
        'description': 'Join us for a cleanup drive in Nairobi.',
      },
      {
        'title': 'Relief Distribution',
        'description': 'Food and water distribution in Turkana.',
      },
    ];

    return Column(
      children: updates
          .map(
            (update) => UpdateCard(
              title: update['title']!,
              description: update['description']!,
            ),
          )
          .toList(),
    );
  }
}

class UpdateCard extends StatelessWidget {
  final String title;
  final String description;

  const UpdateCard({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class UserActions extends StatelessWidget {
  const UserActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actions = [
      {
        'icon': Icons.report,
        'label': 'Report Disaster',
        'route': '/report-disaster',
      },
      {
        'icon': Icons.map,
        'label': 'View Locations',
        'route': '/view-locations',
      },
      {
        'icon': Icons.support,
        'label': 'Contact Support',
        'route': '/contact-support',
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions
          .map(
            (action) => ActionButton(
              icon: action['icon'] as IconData,
              label: action['label'] as String,
              onTap: () {
                Navigator.pushNamed(context, action['route'] as String);
              },
            ),
          )
          .toList(),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ActionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue.withOpacity(0.1),
            child: Icon(icon, color: Colors.blue, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
