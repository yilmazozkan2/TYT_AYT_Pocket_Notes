import 'package:flutter/material.dart';
import 'package:untitled1/constants/custom_bottom_navigation_bar.dart';
import 'package:untitled1/pages/profile_page.dart';
import 'package:untitled1/services/firebase_auth_service.dart';

// ignore: must_be_immutable
class SignPage extends StatelessWidget {
  SignPage({super.key, required this.currentIndex});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (p0) {},
      ),
      body: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.green,
              filled: true,
            ),
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.red,
              filled: true,
            ),
          ),
          ElevatedButton(
              onPressed: () => AuthService().registerWithEmailAndPassword(
                  emailController.text, passwordController.text),
              child: Text('Kayıt Ol')),
          ElevatedButton(
              onPressed: () {
                AuthService()
                    .signInWithEmailAndPassword(
                        emailController.text, passwordController.text)
                    .then((value) => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ),
                        ));
              },
              child: Text('Giriş Yap'))
        ],
      ),
    );
  }
}
