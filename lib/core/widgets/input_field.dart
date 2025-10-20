import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final String label;
  final bool isPassword;
  final TextEditingController? controller;
  const InputField({
    super.key,
    required this.hint,
    required this.label,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        label: Text(label),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }
}
