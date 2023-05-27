import 'package:flutter/material.dart';

import '../../constants/padding.dart';

class EmailTextField extends StatelessWidget {
  EmailTextField({super.key, required this.textController1});
  TextEditingController textController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
}