import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/home_page.dart';

class SignInAnonymousButton extends StatelessWidget {
  const SignInAnonymousButton({super.key});

  @override
  Widget build(BuildContext context) {
   return SizedBox(
      width: 300,
      child: ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance
                .signInAnonymously()
                .then((UserCredential user) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => homePage()),
              );
            });
          },
          child: Text('Login as Guest'.tr,
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: Colors.white))),
    );
  }
}