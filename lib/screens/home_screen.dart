import 'package:flutter/material.dart';
import 'package:disaster_management_app/screens/login_screen.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disaster Management App',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const AuthWrapper(),
      routes: {'/login': (context) => const LoginScreen()},
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  Future<bool> _checkAuthentication() async {
    // Simulate an authentication check (replace with real logic)
    await Future.delayed(const Duration(seconds: 2));
    return false; // Change to true if the user is logged in
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkAuthentication(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
