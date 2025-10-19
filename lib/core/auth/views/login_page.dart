import 'package:flutter/material.dart';
import 'package:login_with_firebase/core/auth/auth_service.dart';
import 'package:login_with_firebase/core/controller/password_controller.dart';
import 'package:login_with_firebase/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String passwordMessage = ''; // Şifre kontrol mesajı
  final PasswordController passwordChecker = PasswordController();
  bool _isSecure = false;

  void isSecure() {
    _isSecure = !_isSecure;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    String result = passwordChecker.passwordControl(passwordController.text);

    setState(() {
      passwordMessage = result;
    });

    if (result != "Şifre kabul edilebilir ✅") return;

    final user = await _auth.createUserWithEmailandPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (user != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Başarılı! 🎉")));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(title: emailController.text),
        ),
      );
    }
  }

  void _onPasswordChanged(String value) {
    String result = passwordChecker.passwordControl(value);
    setState(() {
      passwordMessage = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: SizedBox(
            width: 400,
            height: 360,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Register Page",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Enter your e-mail",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    onChanged: _onPasswordChanged,
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      border: const OutlineInputBorder(),
                      errorText:
                          passwordMessage.isNotEmpty &&
                              passwordMessage != "Şifre kabul edilebilir ✅"
                          ? passwordMessage
                          : null,
                    ),
                  ),
                  if (passwordMessage == "Şifre kabul edilebilir ✅")
                    Text(
                      passwordMessage,
                      style: const TextStyle(color: Colors.green),
                    ),
                  ElevatedButton(
                    onPressed: _signUp,
                    child: const Text("Register"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
