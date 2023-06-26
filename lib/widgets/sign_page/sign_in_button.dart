import 'package:flutter/material.dart';

import '../../pages/home_page.dart';
import '../../services/firebase_auth_service.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });
  final emailController, passwordController;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          AuthService()
              .signInWithEmailAndPassword(
                  emailController.text, passwordController.text)
              .then((value) => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  ));
        },
        child: Text('Giriş yap'));
  }
}
