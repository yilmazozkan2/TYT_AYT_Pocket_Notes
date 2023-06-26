import 'package:flutter/material.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({super.key, required this.emailController});
  final emailController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: 'Email giriniz',
        border: UnderlineInputBorder(),
      ),
    );
  }
}
