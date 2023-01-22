import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:untitled1/constants/padding.dart';
import 'package:untitled1/pages/home_page.dart';

class Iskele extends StatefulWidget {
  @override
  State<Iskele> createState() => _IskeleState();
}

String avatarUrl = '';

class _IskeleState extends State<Iskele> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();

  Future<String> getUserProfileImageDownloadUrl(String uid) async {
    var storageRef = FirebaseStorage.instance.ref().child("user/profile/$uid");
    return await storageRef.getDownloadURL();
  }
  final List locale = [
    {'name': 'TURKISH', 'locale': Locale('tr')},
    {'name': 'ENGLISH', 'locale': Locale('en')},
    {'name': 'ARABIC', 'locale': Locale('ar')},
    {'name': 'SPANISH', 'locale': Locale('es')},
    {'name': 'FRENCH', 'locale': Locale('fr')},
    {'name': 'GERMAN', 'locale': Locale('de')},
    {'name': 'RUSSIAN', 'locale': Locale('ru')},
    {'name': 'INDIAN', 'locale': Locale('hi')},
    {'name': 'CHINESE', 'locale': Locale('zh-cn')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  signInAnon() async {
    UserCredential auth = await FirebaseAuth.instance.signInAnonymously();
    return auth;
  }

  builddialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return alertDialog();
        });
  }

  AlertDialog alertDialog() {
    return AlertDialog(
      title: Text('Choose App Language'),
      content: Container(
        width: double.maxFinite,
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: ProjectDecorations.allPadding,
                child: GestureDetector(
                    onTap: () {
                      print((locale[index]['name']));
                      updateLanguage(locale[index]['locale']);
                    },
                    child: Text(
                      locale[index]['name'],
                    )),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.blue,
              );
            },
            itemCount: locale.length),
      ),
    );
  }

  Future<void> kayitOl() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: textController1.text, password: textController2.text)
        .then((kullanici) {
      FirebaseFirestore.instance
          .collection("Kullanicilar")
          .doc(textController1.text)
          .set({
        'KullaniciEposta': textController1.text,
        'KullaniciSifre': textController2.text,
        'imageUrl':
            'https://i.pinimg.com/474x/7e/94/96/7e9496625377d3fc8821de9b0057c087.jpg'
      });
    });
  }

  girisYap() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: textController1.text, password: textController2.text)
        .then((kullanici) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => homePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: LoginSkeleton(context),
      ),
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
                LangIconButton(context),
              ],
            ),
          ),
          Padding(
            padding: ProjectDecorations.onlyBottomPadding,
            child: AppNameText(context),
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EmailTextField(),
                SizedBox(height: 10),
                PasswordTextField(),
                privacyPolicyLinkAndTermsOfService(),
                SizedBox(height: 20),

                SignUpButton(context),
                SignInButton(),
                SignInAnonymousButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconButton LangIconButton(BuildContext context) {
    return IconButton(
                  onPressed: () {
                    builddialog(context);
                  },
                  icon: Icon(Icons.language),
                  color: Colors.blue);
  }

  Text AppNameText(BuildContext context) {
    return Text('Hackpedia',
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.black));
  }

  Widget privacyPolicyLinkAndTermsOfService() {
    return Padding(
      padding: ProjectDecorations.symetricPadding,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Center(
            child: Text.rich(
                TextSpan(
                    text: 'By continuing, you agree to our ', style: Theme.of(context).textTheme.bodyText1?.copyWith(color:Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Terms of Service', style: Theme.of(context).textTheme.bodyText1?.copyWith(color:Colors.black, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // code to open / launch terms of service link here
                            }
                      ),
                      TextSpan(
                          text: ' and ', style: Theme.of(context).textTheme.bodyText1?.copyWith(color:Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Privacy Policy', style: Theme.of(context).textTheme.bodyText1?.copyWith(color:Colors.black, decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                  }
                            )
                          ]
                      )
                    ]
                )
            )
        ),
      ),
    );
  }
  Widget EmailTextField() {
    return SizedBox(
      width: 300,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Container(
            padding: ProjectDecorations.allPadding,
            child: Icon(Icons.email),
            width: 18,
          ),
          hintText: "Email Adress:",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        controller: textController1,
      ),
    );
  }

  Widget PasswordTextField() {
    return SizedBox(
      width: 300,
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Container(
              padding: ProjectDecorations.allPadding,
              child: Icon(Icons.password),
              width: 18,
            ),
            hintText: "Password:",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(color: Colors.black, width: 8))),
        controller: textController2,
      ),
    );
  }

  Widget SignUpButton(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ElevatedButton(
          onPressed: () {
            if(textController1.text.isNotEmpty || textController1.text == ' '
                && textController2.text.isNotEmpty || textController2.text == ' '){
              kayitOl();
            }
          },
          child: Text('signup'.tr,
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: Colors.white))),
    );
  }

  Widget SignInButton() {
    return SizedBox(
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
    );
  }

  Widget SignInAnonymousButton(BuildContext context) {
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
