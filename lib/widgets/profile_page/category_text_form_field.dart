import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryTextFormField extends StatelessWidget {
  CategoryTextFormField({
    super.key,
    required this.textController,
    required this.onChanged,
  });
  final textController;
  Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textController,
        decoration: InputDecoration(
          hintText: 'Kategori yazınız.',
          border: InputBorder.none,
          fillColor: Colors.green,
          filled: true,
        ),
        onChanged: onChanged);
  }
}
