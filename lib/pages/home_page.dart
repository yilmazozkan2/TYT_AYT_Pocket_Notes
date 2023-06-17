import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled1/constants/custom_bottom_navigation_bar.dart';

import '../widgets/profile_page/buttons/image_buttons.dart';
import '../widgets/profile_page/buttons/sign_out_button.dart';
import '../widgets/profile_page/category_text_form_field.dart';
import '../widgets/profile_page/images_builder.dart';
import '../widgets/profile_page/square_tile.dart';
import '../widgets/profile_page/square_tile_navigate.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  var output;
  String category = '';
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeHome(context),
    );
  }

  Scaffold HomeHome(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: HomeBody(context),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            setState(() => _currentIndex = index);
          } else if (index == 1) {
            print('uygulamadan çıkıldı');
            exit(0);
          }
        },
      ),
    );
  }

  Column HomeBody(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SquareTile(
                imagePath: 'assets/images/google.png',
                onTap: () => Navigator.of(context)
                    .pushReplacement(SquareTileNavigate())),
            SignOutButton(),
          ],
        ),
        CategoryTextFormField(
          textController: textController,
          onChanged: (value) {
            setState(() {
              category = value;
            });
          },
        ),
        ImageButtons(
          category: category,
          output: output,
        ),
        ImagesBuilder(
          category: category,
          output: output,
        )
      ],
    );
  }
}
