import 'package:flutter/material.dart';

import '../../constants/padding.dart';

// ignore: must_be_immutable
class PasswordTextField extends StatelessWidget {
  PasswordTextField({super.key, required this.textController2});
  TextEditingController textController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            hintText: "Şifre:",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(color: Colors.black, width: 8))),
        controller: textController2,
      ),
    );
  }
}
