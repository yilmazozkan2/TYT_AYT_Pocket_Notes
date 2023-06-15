import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DeletePostButton extends StatelessWidget {
  DeletePostButton({
    super.key,
    required this.document,
  });
  DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => FirebaseFirestore.instance
          .collection('Paylasimlar')
          .doc(document.id)
          .delete(),
      child: Text(
        'deletepost'.tr,
        style:
            Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.blue),
      ),
    );
  }
}
