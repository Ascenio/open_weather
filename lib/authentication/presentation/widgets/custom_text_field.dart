import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    super.key,
  });

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
      validator: validator,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
