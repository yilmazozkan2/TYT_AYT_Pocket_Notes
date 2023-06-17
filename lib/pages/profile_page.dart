import 'package:flutter/material.dart';
import 'package:untitled1/constants/custom_bottom_navigation_bar.dart';

import 'package:untitled1/widgets/profile_page/category_text_form_field.dart';

//Widgets
import '../widgets/profile_page/image_buttons.dart';
import '../widgets/profile_page/images_builder.dart';
import '../widgets/profile_page/sign_out_button.dart';
import '../widgets/profile_page/square_tile.dart';
import '../widgets/profile_page/square_tile_navigate.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final textController = TextEditingController();
  var output;
  String category = '';
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: ProfileBody(context),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (p0) {},
        ),
      ),
    );
  }

  Widget ProfileBody(BuildContext context) {
    return Column(
      children: [
        SquareTile(
            imagePath: 'assets/images/google.png',
            onTap: () => Navigator.of(context)
                .pushReplacement(SquareTileNavigate(_currentIndex))),
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
        SignOutButton(
          currentIndex: _currentIndex,
        ),
        ImagesBuilder(
          category: category,
          output: output,
        )
      ],
    );
  }
}
