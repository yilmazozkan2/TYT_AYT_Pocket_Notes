import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/widgets/profile_page/call_image.dart';
import 'package:untitled1/widgets/profile_page/image_buttons.dart';

class ImageAndButtonsField extends StatelessWidget {
  ImageAndButtonsField({
    super.key,
    required this.output,

  });
  FirebaseAuth auth = FirebaseAuth.instance;
  var output;
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CallImage(output: output, auth: auth,),
              SizedBox(height: 5),
            ],
          ),
          ImageButtons(auth: auth,),
        ],
      ),
    );
  }
}
