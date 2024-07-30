import 'package:flutter/material.dart';

class ViewRecentPostsScreen extends StatelessWidget {
  const ViewRecentPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Posts'),
      ),
      body: const Center(
        child: Text('List of recent posts goes here'),
      ),
    );
  }
}
