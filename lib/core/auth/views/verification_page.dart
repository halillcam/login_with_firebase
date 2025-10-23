import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/core/auth/auth_service.dart';
import 'package:login_with_firebase/core/wrapper.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key, required this.user});
  final User user;
  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final AuthService _auth = AuthService();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _auth.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Wrapper()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              "We are sending the email verification message to your inbox. Can you verify it?",
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _auth.sendEmailVerification();
              },
              child: Text("I verified"),
            ),
          ],
        ),
      ),
    );
  }
}
