import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/constants/padding.dart';
import 'package:untitled1/pages/home_page.dart';

// Widgets
import '../widgets/login_page/app_name_text.dart';
import '../widgets/login_page/email_text_field.dart';
import '../widgets/login_page/language_icon_button.dart';
import '../widgets/login_page/password_text_field.dart';
import '../widgets/login_page/signUp_button.dart';

class Iskele extends StatefulWidget {
  @override
  State<Iskele> createState() => _IskeleState();
}

class _IskeleState extends State<Iskele> {
  final textController1 = TextEditingController();
  final textController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: MyAppBar(),
        backgroundColor: Colors.white,
        body: LoginSkeleton(context),
      ),
    );
  }

  AppBar MyAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget LoginSkeleton(BuildContext context) {
    return Align(
      child: Column(
        children: [
          Padding(
            padding: ProjectDecorations.onlyRightPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LanguageIconButton(),
              ],
            ),
          ),
          Padding(
            padding: ProjectDecorations.onlyBottomPadding,
            child: AppNameText(),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EmailTextField(textController1: textController1),
                SizedBox(height: 10),
                PasswordTextField(textController2: textController2),
                SizedBox(height: 20),
                SignUpButton(),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () {
                        girisYap();
                      },
                      child: Text('signin'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .button
                              ?.copyWith(color: Colors.white))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  girisYap() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: textController1.text, password: textController2.text)
        .then((kullanici) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }
}
