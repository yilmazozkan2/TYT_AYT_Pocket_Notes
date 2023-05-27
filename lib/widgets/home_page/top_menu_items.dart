import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/padding.dart';
import '../../pages/login_page.dart';
import '../../pages/profile_page.dart';

class TopMenuItems extends StatelessWidget {
  TopMenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    return Container(
      height: 60,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: ['home'.tr, 'profile'.tr, 'signout'.tr]
              .map((e) => Container(
                  margin: ProjectDecorations.symetricPadding,
                  child: OutlinedButton(
                    onPressed: () {
                      if (e == 'profile'.tr &&
                          auth.currentUser?.email != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
                        );
                      }
                      if (e == 'signout'.tr) {
                        //email boş ise yani tokenli kullanıcı ise çıkışa bastığında tokeni silinsin
                        //oturumu kapansın ve login sayfasına yönlendirilsin
                        if (auth.currentUser?.email == null) {
                          auth.currentUser?.delete();
                          FirebaseAuth.instance.signOut();
                          PushAndRemovePage(context);
                        } else
                          PushAndRemovePage(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: Text(e,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.blue)),
                  )))
              .toList()),
    );
  }

  Future<dynamic> PushAndRemovePage(BuildContext context) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Iskele(),
      ),
      (route) => false,
    );
  }
}
