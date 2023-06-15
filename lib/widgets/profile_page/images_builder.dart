import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/widgets/profile_page/pinterest_style_grid_view.dart';

// ignore: must_be_immutable
class ImagesBuilder extends StatelessWidget {
  ImagesBuilder({
    super.key,
    required this.output,
    required this.category,
  });

  final auth = FirebaseAuth.instance;
  var output;
  String category;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
          return PinterestStyleGridView(images: images);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
