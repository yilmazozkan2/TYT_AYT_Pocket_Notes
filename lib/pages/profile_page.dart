import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/widgets/profile_page/category_text_form_field.dart';

import '../widgets/profile_page/image_buttons.dart';
import '../widgets/profile_page/pinterest_style_grid_view.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var output;
  final auth = FirebaseAuth.instance;
  final textController = TextEditingController();
  String category = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ProfileSkeleton(context),
      ),
    );
  }

  Widget ProfileSkeleton(BuildContext context) {
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
          output: output,
          category: textController.text,
        ),
        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('Kullanicilar')
              .doc(auth.currentUser!.email)
              .snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasError)
              return Text('Error = ${snapshot.error}');
            else if (snapshot.hasData) {
              output = snapshot.data!.data();
              var images = output!['images']
                  .where((image) => image['kategori'] == category)
                  .toList();
              return Expanded(
                child: PinterestStyleGridView(images: images),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        )
      ],
    );
  }
}
