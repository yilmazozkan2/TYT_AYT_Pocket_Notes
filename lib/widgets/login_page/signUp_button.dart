import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SignUpButton extends StatelessWidget {
  SignUpButton({super.key});
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ElevatedButton(
          onPressed: () {
            if (textController1.text.isNotEmpty ||
                textController1.text == ' ' &&
                    textController2.text.isNotEmpty ||
                textController2.text == ' ') {
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
}
