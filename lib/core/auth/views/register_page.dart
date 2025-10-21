import 'package:flutter/material.dart';
import 'package:login_with_firebase/core/auth/auth_service.dart';
import 'package:login_with_firebase/core/auth/views/login_page.dart';
import 'package:login_with_firebase/core/controller/password_controller.dart';
import 'package:login_with_firebase/core/widgets/input_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String passwordMessage = ''; // Şifre kontrol mesajı
  final PasswordController passwordChecker = PasswordController();
  bool _isSecure = false;

  void isSecure() {
    setState(() {
      _isSecure = !_isSecure;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();

    super.dispose();
  }

  Future<void> _signUp() async {
    String result = passwordChecker.passwordControl(_passwordController.text);

    setState(() {
      passwordMessage = result;
    });

    if (result != "Şifre kabul edilebilir ✅") return;

    final user = await _auth.createUserWithEmailandPassword(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (user != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Successful 🎉")));
      // Kayıt başarılıysa RegisterPage'i kapat; altta Wrapper authState'i görüp UserPage'e geçecek.
      if (mounted) {
        Navigator.of(context).pop();
      }
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
                  InputField(
                    hint: "Enter Name",
                    label: "Name",
                    controller: _nameController,
                  ),
                  InputField(
                    hint: "Enter e-mail",
                    label: "Email",
                    controller: _emailController,
                  ),
                  _passwordField(),
                  if (passwordMessage == "Şifre kabul edilebilir ✅")
                    Text(
                      passwordMessage,
                      style: const TextStyle(color: Colors.green),
                    ),
                  SizedBox(
                    width: 400,
                    height: 20,
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Zaten üyeyim",
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

  TextField _passwordField() {
    return TextField(
      controller: _passwordController,
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
    );
  }
}
