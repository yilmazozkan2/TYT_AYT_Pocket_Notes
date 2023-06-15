import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/pages/fullscreen_page.dart';

import '../widgets/profile_page/image_buttons.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(child: KullaniciyaAit());
  }
}

class KullaniciyaAit extends StatefulWidget {
  @override
  State<KullaniciyaAit> createState() => _KullaniciyaAitState();
}

class _KullaniciyaAitState extends State<KullaniciyaAit> {
  var output;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
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
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
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
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage:
                              NetworkImage(output['imageUrl'][index]),
                        ),
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
