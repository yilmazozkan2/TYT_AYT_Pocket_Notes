import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constants/padding.dart';
import 'card_tag.dart';
import 'card_visit.dart';

class CardPosts extends StatelessWidget {
   CardPosts({super.key, required this.name, required this.tag});

  final String name;
  var tag;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: name != "" && name != null
            ? FirebaseFirestore.instance
                .collection('Paylasimlar')
                .where("searchIndex", arrayContains: name)
                .snapshots()
            : FirebaseFirestore.instance
                .collection("Paylasimlar")
                .orderBy('paylasimTarihi', descending: true)
                .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return new Text(
              'Loading...',
            );
          return new ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot myPost = snapshot.data!.docs[
                  index]; // documentsnapshotu dışarıya çıkarma yoksa resimler gözükürken tek resim gözükür
              tag = myPost['etiket'];
              return Center(
                child: Card(
                  margin: ProjectDecorations.cardPadding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CardVisit(myPost: myPost),
                      ListTile(
                        title: SelectableText(
                          myPost['paylasimMetni'],
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      CardTag(tag: tag),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}