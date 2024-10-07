import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign In
  Future<User?> _signInWithPassword(String email, String password)async {
    try {
      UserCendential result = await _auth.signInWithPassword(email:email,password:password)
    } catch (e) {
      
    }
  }
}
