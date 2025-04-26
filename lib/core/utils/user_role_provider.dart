import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRoleProvider with ChangeNotifier {
  String _role = '';
  bool _isLoading = true;

  String get role => _role;
  bool get isLoading => _isLoading;

  Future<void> loadUserRole() async {
    _isLoading = true;
    notifyListeners();
    
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        _role = userDoc.data()?['role'] ?? '';
      }
    }
    
    _isLoading = false;
    notifyListeners();
  }
}
