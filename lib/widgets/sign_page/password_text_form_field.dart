import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({super.key, required this.passwordController});
  final passwordController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
        hintText: 'Şifre giriniz',
        border: UnderlineInputBorder(),
      ),
    );
  }
}
