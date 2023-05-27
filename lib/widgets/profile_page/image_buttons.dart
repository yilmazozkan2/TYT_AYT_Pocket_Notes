import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ImageButtons extends StatefulWidget {
  const ImageButtons({super.key});

  @override
  State<ImageButtons> createState() => _ImageButtonsState();
}

class _ImageButtonsState extends State<ImageButtons> {
  FirebaseAuth auth = FirebaseAuth.instance;
  File? file; //galeriden seçilen, yüklenen ve silinen dosya
  String imageUrl = '';
  final db = FirebaseFirestore.instance;
  var image;
  final ImagePicker _picker = ImagePicker();



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
            db.collection('Kullanicilar').doc(auth.currentUser!.email);
        ref.set(
          {
            //'KullaniciId': uid,
            'imageUrl': imageUrl
          },
          SetOptions(merge: true),
        );
      } else {
        DocumentReference ref =
            db.collection('Kullanicilar').doc(auth.currentUser!.email);
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

Future _pickImageGallery() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        file = File(image.path);
      });
    }
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
              uploadProfileImage(auth.currentUser!.uid);
            },
            child: Text('saveselectedimage'.tr,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.blue))),
      ],
    );
  }
}
