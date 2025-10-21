import 'package:flutter/material.dart';
import 'package:login_with_firebase/core/auth/auth_service.dart';
import 'package:login_with_firebase/core/auth/views/register_page.dart';
import 'package:login_with_firebase/core/widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // login

  Future<void> _login() async {
    final user = await _auth.loginUserWithEmailandPassword(
      _emailController.text,
      _passwordController.text,
    );
    if (user != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Successful")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Error")));
      // await Future.delayed(Duration(seconds: 2)); // opsiyonel
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                  const Text("Login Page"),
                  InputField(
                    hint: "Enter e-mail",
                    label: "e-mail",
                    controller: _emailController,
                  ),
                  InputField(
                    hint: "Enter Password",
                    label: "Password",
                    controller: _passwordController,
                    isPassword: true,
                  ),
                  SizedBox(
                    width: 400,
                    height: 20,
                    child: Row(
                      children: [
                        Text("Üye değilmisiniz ? "),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Üye olun",
                            style: TextStyle(
                              color: Colors.blue,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _login();
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
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
