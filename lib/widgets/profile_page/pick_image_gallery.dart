import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class PickImageGallery extends StatefulWidget {
  PickImageGallery({super.key, required this.auth});
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  State<PickImageGallery> createState() => _PickImageGalleryState();
}

class _PickImageGalleryState extends State<PickImageGallery> {
  var image;
  String imageUrl = '';

  final ImagePicker _picker = ImagePicker();
  File? file; //galeriden seçilen, yüklenen ve silinen dosya
  final db = FirebaseFirestore.instance;

  Future _pickImageGallery() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        file = File(image.path);
      });
    }
  }

  void _showPicker(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('gallery'.tr),
                    onTap: () {
                      _pickImageGallery();
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          ));
        });
  }

/*Firebase firestore veri tabanına resim Yükleme
  Oturum açmış kullanıcının email adresine göre bilgilerini güncelliyor karışmıyor  */
  uploadProfileImage(String uid) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('profileImage/${basename(file!.path)}}');
    UploadTask uploadTask = reference.putFile(File(file!.path));
    TaskSnapshot snapshot = await uploadTask;
    await uploadTask.whenComplete(() async {
      imageUrl = await snapshot.ref.getDownloadURL();
      //başta gelen imageurl üzerine yazar
      if (imageUrl.isNotEmpty) {
        var db = FirebaseFirestore.instance;
        DocumentReference ref =
            db.collection('Kullanicilar').doc(widget.auth.currentUser!.email);
        ref.set(
          {
            //'KullaniciId': uid,
            'imageUrl': imageUrl
          },
          SetOptions(merge: true),
        );
      } else {
        DocumentReference ref =
            db.collection('Kullanicilar').doc(widget.auth.currentUser!.email);
        ref.set(
          {
            //'KullaniciId': uid,
            'imageUrl':
                'https://upload.wikimedia.org/wikipedia/en/b/bf/Tobey_Maguire_as_Spider-Man.jpg'
          },
          SetOptions(merge: true),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      OutlinedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        onPressed: () {
          _showPicker(context);
        },
        child: Text('selectfromgallery'.tr,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: Colors.blue))),
        SizedBox(width: 5),
        OutlinedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            onPressed: () {
              uploadProfileImage(widget.auth.currentUser!.uid);
            },
            child: Text('saveselectedimage'.tr,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.blue))),
    ]);
  }
}
