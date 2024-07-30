import 'package:flutter/material.dart';

class DisasterLocationsScreen extends StatelessWidget {
  DisasterLocationsScreen({super.key});

  final List<Map<String, String>> disasterLocations = [
    {'name': 'Flood in Nairobi', 'description': 'Severe flooding in Nairobi area'},
    {'name': 'Earthquake in Kitale', 'description': 'Magnitude 5.3 earthquake'},
    {'name': 'Wildfire in Maasai Mara', 'description': 'Ongoing wildfire in Maasai Mara'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Disaster Locations')),
      body: ListView.builder(
        itemCount: disasterLocations.length,
        itemBuilder: (context, index) {
          final location = disasterLocations[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(location['name'] ?? 'Unknown', style: Theme.of(context).textTheme.titleLarge),
              subtitle: Text(location['description'] ?? 'No description available', style: Theme.of(context).textTheme.bodyLarge),
              leading: const Icon(Icons.location_on, color: Colors.redAccent),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DisasterDetailScreen(
                      name: location['name'] ?? 'Unknown',
                      description: location['description'] ?? 'No description available',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DisasterDetailScreen extends StatelessWidget {
  final String name;
  final String description;

  const DisasterDetailScreen({required this.name, required this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge, // Changed to titleLarge
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge, // Changed to bodyLarge
            ),
            const SizedBox(height: 16.0),
            // Add more details or interactive elements here if needed
          ],
        ),
      ),
    );
  }
}