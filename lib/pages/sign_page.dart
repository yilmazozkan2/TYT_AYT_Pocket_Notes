import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled1/constants/custom_bottom_navigation_bar.dart';
import 'package:untitled1/pages/home_page.dart';

//Widgets
import '../widgets/sign_page/email_text_form_field.dart';
import '../widgets/sign_page/password_text_form_field.dart';
import '../widgets/sign_page/sign_in_button.dart';
import '../widgets/sign_page/sign_up_button.dart';

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
        elevation: 0,
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
            EmailTextFormField(emailController: emailController),
            SizedBox(height: 10),
            PasswordTextFormField(passwordController: passwordController),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  SignUpButton(
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                  SizedBox(width: 30.0),
                  SignInButton(
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
