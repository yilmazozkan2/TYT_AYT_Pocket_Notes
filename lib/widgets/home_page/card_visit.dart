import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/widgets/home_page/popup_menu_button.dart';

import '../../constants/padding.dart';
import 'email_date_text_column.dart';

class CardVisit extends StatelessWidget {
   CardVisit({super.key, required this.myPost});

  final DocumentSnapshot<Object?> myPost;
  var output;


  @override
  Widget build(BuildContext context) {
     return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
                      myPost['KullaniciResmi'] != null
                          ? CircleAvatar(
                              radius: 27,
                              backgroundImage:
                                  NetworkImage(myPost['KullaniciResmi']))
                          : Center()
                    ],
                  ),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        Expanded(
          child: EmailDateTextColumn(myPost: myPost),
        ),
        PopUpMenuButton(myPost: myPost),
      ],
    );
  }
}