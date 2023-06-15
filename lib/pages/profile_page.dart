import 'package:flutter/material.dart';

import 'package:untitled1/widgets/profile_page/category_text_form_field.dart';

//Widgets
import '../widgets/profile_page/image_buttons.dart';
import '../widgets/profile_page/images_builder.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final textController = TextEditingController();
  var output;
  String category = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: ProfileBody(context),
      ),
    );
  }

  Widget ProfileBody(BuildContext context) {
    return Column(
      children: [
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
