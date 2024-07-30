import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'user_role_provider.dart'; 

import 'home_screen.dart'; 
import 'admin_dashboard.dart';
import 'view_recent_posts_screen.dart'; 
import 'view_disaster_locations_screen.dart'; 
import 'suggest_solutions_screen.dart';  
import 'user_dashboard.dart'; 
import 'public_queries.dart'; 
import 'about.dart'; 
import 'contact.dart'; 
import 'help_support.dart';
import 'chat_screen.dart'; 
import 'login_screen.dart';
import 'register_screen.dart';
import 'profile.dart';
import 'view_profile_screen.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserRoleProvider()),
        // Add other providers here if needed
      ],
      child: MaterialApp(
        title: 'Disaster Management App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthCheck(),
        routes: {
          '/admin': (context) => const AdminDashboard(),
          '/admin/recent_posts': (context) => const ViewRecentPostsScreen(),
          '/admin/disaster_locations': (context) => const ViewDisasterLocationsScreen(),
          '/admin/suggest_solutions': (context) => const SuggestSolutionsScreen(),
          '/user': (context) => const UserDashboard(),
          '/public': (context) => const PublicQueries(),
          '/profile': (context) => const Profile(),
          '/profile/view': (context) => const ViewProfileScreen(),
          '/profile/edit': (context) => const EditProfileScreen(),
          '/profile/change_password': (context) => const ChangePasswordScreen(),
          '/about': (context) => const About(),
          '/contact': (context) => const Contact(),
          '/help': (context) => const HelpSupport(),
          '/home': (context) => const HomeScreen(),
          '/chat': (context) => const ChatScreen(), 
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
        },
      ),
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  void initState() {
    super.initState();
    // Ensure UserRoleProvider loads the role when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserRoleProvider>(context, listen: false).loadUserRole();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return const LoginScreen();
          } else {
            return Consumer<UserRoleProvider>(
              builder: (context, userRoleProvider, child) {
                if (userRoleProvider.isLoading) {
                  return const CircularProgressIndicator(); // Show a loading indicator
                } else {
                  return const HomeScreen(); // Navigate to the home screen after role is loaded
                }
              },
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
