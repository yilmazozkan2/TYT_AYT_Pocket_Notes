import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPostText extends StatelessWidget {
  const MyPostText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('mypost'.tr, style: Theme.of(context).textTheme.bodyText1);
  }
}
