import 'package:flutter/material.dart';
import 'package:login_with_firebase/core/auth/auth_service.dart';
import 'package:login_with_firebase/core/widgets/input_field.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final TextEditingController _email = TextEditingController();
  final AuthService _auth = AuthService();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter e-mail to send you a password Reset"),
            const SizedBox(height: 20),
            InputField(hint: "Enter Email", label: "Email", controller: _email),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _auth.sendPasswordResetLink(_email.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Check your mail inbox")),
                );
                Navigator.pop(context);
              },
              child: Text("Send E-Mail"),
            ),
          ],
        ),
      ),
    );
  }
}
