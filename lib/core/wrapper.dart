import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/core/auth/views/login_page.dart';
import 'package:login_with_firebase/core/auth/views/user_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("error"));
          } else {
            if (snapshot.data == null) {
              return const LoginPage();
            } else {
              return UserPage(userName: "userName");
            }
          }
        },
      ),
    );
  }
}
