import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:untitled1/pages/fullscreen_page.dart';

import '../widgets/profile_page/image_buttons.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var output;
  final auth = FirebaseAuth.instance;

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
    return SafeArea(
      child: myPostsField(),
    );
  }

  Widget myPostsField() {
    return Column(
      children: [
        ImageButtons(output: output),
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
              return Expanded(
                child: MasonryGridView.builder(
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemCount: output!['imageUrl'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FullScreen(
                                  imageUrl: output['imageUrl'][index])));
                        },
                        child: Image.network(output['imageUrl'][index]),
                      ),
                    );
                  },
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        )
      ],
    );
  }
}
