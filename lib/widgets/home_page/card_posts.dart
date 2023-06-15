import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constants/padding.dart';

// ignore: must_be_immutable
class CardPosts extends StatelessWidget {
  CardPosts({super.key});

  var output;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('Paylasimlar')
            .doc()
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError)
            return Text('Error = ${snapshot.error}');
          else if (snapshot.hasData) {
            output = snapshot.data!.data();
            return Container(
              child: Padding(
                padding: ProjectDecorations.allPadding8,
                child: Column(
                  children: [
                    output['KullaniciResmi'] != null
                        ? CircleAvatar(
                            radius: 27,
                            backgroundImage:
                                NetworkImage(output['KullaniciResmi']))
                        : CircleAvatar(
                            radius: 27,
                            backgroundImage:
                                NetworkImage(output['KullaniciResmi'])),
                  ],
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
