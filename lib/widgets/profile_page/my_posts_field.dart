import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyPostsField extends StatelessWidget {
  MyPostsField({
    super.key,
    required this.tag,
    required this.etiket,
  });

  FirebaseAuth auth = FirebaseAuth.instance;
  var tag;
  TextEditingController controller2 = new TextEditingController();
  String etiket;
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Paylasimlar')
            .where('KullaniciId', isEqualTo: auth.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text('loading'.tr);
          return new ListView(
            shrinkWrap: false,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              tag = document['etiket'];
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //SelectableText!
                    new SelectableText(document['paylasimMetni'],
                        style: Theme.of(context).textTheme.bodyText1),
                    Text(
                        DateFormat('dd/MM/yyyy     HH:mm').format(
                          document['paylasimTarihi'].toDate(),
                        ),
                        style: Theme.of(context).textTheme.bodyText1),
                    Text('#$tag',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.blue)),
                    Container(
                      child: TextFormField(
                        controller: controller2,
                        decoration: InputDecoration.collapsed(
                          hintText: "entertag".tr,
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.grey),
                        onChanged: (_val) {
                          etiket = _val;
                        },
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      TextButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('Paylasimlar')
                                .doc(document.id)
                                .update({
                              'etiket': etiket,
                            });
                            controller2.clear();
                          },
                          child: Text('savetag'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: Colors.blue))),
                      TextButton(
                        onPressed: () => FirebaseFirestore.instance
                            .collection('Paylasimlar')
                            .doc(document.id)
                            .delete(),
                        child: Text(
                          'deletepost'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.blue),
                        ),
                      ),
                    ]),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
