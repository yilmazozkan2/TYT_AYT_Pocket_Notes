import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/padding.dart';

class CallImage extends StatelessWidget {
  CallImage({
    super.key,
    required this.output,
    required this.auth,

  });
  FirebaseAuth auth = FirebaseAuth.instance;
  var output;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    output!['imageUrl'] == ""
                        ? CircleAvatar(
                            radius: 55,
                            backgroundImage: NetworkImage(output['imageUrl']))
                        : Center(
                            child: CircleAvatar(
                                radius: 55,
                                backgroundImage:
                                    NetworkImage(output['imageUrl'])),
                          ),
                    Padding(
                      padding: ProjectDecorations.onlyLeftPadding,
                      child: Text(
                        output['KullaniciEposta'],
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
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
