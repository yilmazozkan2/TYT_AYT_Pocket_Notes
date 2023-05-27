import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/padding.dart';
//Pages
import '../../pages/home_page.dart';
import '../../pages/login_page.dart';

class TopMenuItems extends StatelessWidget {
  const TopMenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 60,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: ['home'.tr, 'profile'.tr, 'signout'.tr]
                    .map((e) => Container(
                        margin: ProjectDecorations.symetricPadding,
                        child: OutlinedButton(
                          onPressed: () {
                            if (e == 'home'.tr) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => homePage()),
                              );
                            }
                            if (e == 'signout'.tr) {
                              FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Iskele(),
                                ),
                                (route) => false,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: Text(
                            e,
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(color:Colors.blue)
                          ),
                        )))
                    .toList()),
          );
  }
}