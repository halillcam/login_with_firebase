import 'package:flutter/material.dart';
import 'package:login_with_firebase/core/auth/auth_service.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key, required this.userName});
  final String userName;

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Welcome"),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}
