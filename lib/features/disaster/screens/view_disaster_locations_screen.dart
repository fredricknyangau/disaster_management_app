import 'package:flutter/material.dart';

class ViewDisasterLocationsScreen extends StatelessWidget {
  const ViewDisasterLocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disaster Locations'),
      ),
      body: const Center(
        child: Text('Map or list of disaster locations goes here'),
      ),
    );
  }
}
