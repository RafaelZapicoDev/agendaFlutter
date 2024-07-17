import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipes/View/viewResources/forms/login_user.dart';
import 'package:recipes/View/viewResources/pages/home.dart';

class LoginVerify extends StatelessWidget {
  const LoginVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Home();
          } else {
            return const LoginUser();
          }
        },
      ),
    );
  }
}
