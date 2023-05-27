import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmailDateTextColumn extends StatelessWidget {
  final DocumentSnapshot<Object?> myPost;

  const EmailDateTextColumn({Key? key, required this.myPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          myPost['KullaniciEposta'],
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          DateFormat('dd/MM/yyyy - HH:mm').format(
            myPost['paylasimTarihi'].toDate(),
          ),
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
