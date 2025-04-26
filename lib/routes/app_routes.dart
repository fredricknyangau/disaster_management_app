import 'package:flutter/material.dart';

// Screens
import '../features/dashboard/screens/admin_dashboard.dart';
import '../features/posts/screens/view_recent_posts_screen.dart';
import '../features/disaster/screens/view_disaster_locations_screen.dart';
import '../features/disaster/screens/suggest_solutions_screen.dart';
import '../features/dashboard/screens/user_dashboard.dart';
import '../features/posts/screens/public_queries.dart';
import '../features/profile/screens/profile.dart';
import '../features/profile/screens/view_profile_screen.dart';
import '../features/profile/screens/edit_profile_screen.dart';
import '../features/auth/screens/change_password_screen.dart';
import '../features/support/screens/about.dart';
import '../features/support/screens/contact.dart';
import '../features/support/screens/help_support.dart';
import '../features/dashboard/screens/home_screen.dart';
import '../features/chat/screens/chat_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
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
  };
}
