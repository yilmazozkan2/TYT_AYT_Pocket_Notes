import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled1/constants/custom_bottom_navigation_bar.dart';
import 'package:untitled1/pages/home_page.dart';
import 'package:untitled1/services/firebase_auth_service.dart';

// ignore: must_be_immutable
class SignPage extends StatefulWidget {
  SignPage({Key? key}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            return;
          } else if (index == 1) {
            print('uygulamadan çıkıldı');
            exit(0);
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            EmailTextFormField(),
            SizedBox(height: 10),
            PasswordTextFormField(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  SignUpButton(),
                  SizedBox(width: 30.0),
                  SignInButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget SignUpButton() {
    return ElevatedButton(
        onPressed: () => AuthService().registerWithEmailAndPassword(
            emailController.text, passwordController.text),
        child: Text('Kaydol'));
  }

  Widget SignInButton() {
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

  TextFormField EmailTextFormField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: 'Email giriniz',
        border: UnderlineInputBorder(),
      ),
    );
  }

  TextFormField PasswordTextFormField() {
    return TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
        hintText: 'Şifre giriniz',
        border: UnderlineInputBorder(),
      ),
    );
  }
}
