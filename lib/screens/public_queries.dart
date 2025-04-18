import 'package:flutter/material.dart';

class PublicQueries extends StatelessWidget {
  const PublicQueries({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Public Queries')),
      body: Center(child: Text('Submit or view public queries here')),
    );
  }
}
