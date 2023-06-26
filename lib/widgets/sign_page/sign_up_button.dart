import 'package:flutter/material.dart';

import '../../services/firebase_auth_service.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });
  final emailController, passwordController;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => AuthService().registerWithEmailAndPassword(
            emailController.text, passwordController.text),
        child: Text('Kaydol'));
  }
}
