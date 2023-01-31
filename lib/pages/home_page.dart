import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/constants/padding.dart';
import 'package:untitled1/pages/login_page.dart';
import 'package:untitled1/pages/profile_page.dart';
import 'package:translator/translator.dart';

enum MenuItem { item1, item2, item3, item4, item5, item6, item7, item8, item9 }

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _controller = TextEditingController();
  final db = FirebaseFirestore.instance;
  var output;
  var output2;
  String name = '';
  String etiket = '';
  var tag;
  GoogleTranslator translator = GoogleTranslator();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: HomeSkeleton(context),
      ),
    );
  }

  SafeArea HomeSkeleton(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
            child: TopMenuItems(context),
          ),
          Padding(
            padding: ProjectDecorations.aSymetricPadding,
            child: Row(
              children: [
                Text(
                  'Hacker Community',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Flexible(
                  child: Padding(
                    padding: ProjectDecorations.onlyLeftPadding,
                    child: TextField(
                      onChanged: (val) => initiateSearch(val),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        prefixIcon: Container(
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.search),
                          width: 18,
                        ),
                        hintText: "search".tr,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: ProjectDecorations.aSymetricPadding,
            child: Text(output2 == null ? "" : output2.toString(),
                style: Theme.of(context).textTheme.bodyText1),
          ),
          Divider(color: Colors.blue, height: 2, thickness: 2),
          CardPosts(),
        ],
      ),
    );
  }

  Expanded CardPosts() {
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
                      Cardvisit(myPost, context),
                      ListTile(
                        title: SelectableText(
                          myPost['paylasimMetni'],
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Tag(),
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

  Row Cardvisit(DocumentSnapshot<Object?> myPost, BuildContext context) {
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
          child: EmailDateTextColumn(myPost, context),
        ),
        popupMenuButton(context, myPost),
      ],
    );
  }

  Column EmailDateTextColumn(DocumentSnapshot<Object?> myPost, BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(myPost['KullaniciEposta'],
                style: Theme.of(context).textTheme.bodyText1),
            Text(
                DateFormat('dd/MM/yyyy - HH:mm').format(
                  myPost['paylasimTarihi'].toDate(),
                ),
                style: Theme.of(context).textTheme.bodyText1),
          ],
        );
  }

  Padding Tag() {
    return Padding(
      padding: ProjectDecorations.aSymetricPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('#$tag',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(color:Colors.blue)),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  PopupMenuButton<MenuItem> popupMenuButton(
      BuildContext context, DocumentSnapshot<Object?> myPost) {
    return PopupMenuButton(
        icon: Icon(
          Icons.g_translate,
          color: Theme.of(context).primaryColor,
        ),
        onSelected: (value) {
          if (value == MenuItem.item1) {
            translator
                .translate(myPost['paylasimMetni'], from: 'auto', to: 'tr')
                .then((value) {
              setState(() {
                output2 = value;
              });
            });
          }
          if (value == MenuItem.item2) {
            translator
                .translate(myPost['paylasimMetni'], from: 'auto', to: 'en')
                .then((value) {
              setState(() {
                output2 = value;
              });
            });
          }
          if (value == MenuItem.item3) {
            translator
                .translate(myPost['paylasimMetni'], from: 'auto', to: 'ar')
                .then((value) {
              setState(() {
                output2 = value;
              });
            });
          }
          if (value == MenuItem.item4) {
            translator
                .translate(myPost['paylasimMetni'], from: 'auto', to: 'es')
                .then((value) {
              setState(() {
                output2 = value;
              });
            });
          }
          if (value == MenuItem.item5) {
            translator
                .translate(myPost['paylasimMetni'], from: 'auto', to: 'fr')
                .then((value) {
              setState(() {
                output2 = value;
              });
            });
          }
          if (value == MenuItem.item6) {
            translator
                .translate(myPost['paylasimMetni'], from: 'auto', to: 'de')
                .then((value) {
              setState(() {
                output2 = value;
              });
            });
          }
          if (value == MenuItem.item7) {
            translator
                .translate(myPost['paylasimMetni'], from: 'auto', to: 'ru')
                .then((value) {
              setState(() {
                output2 = value;
              });
            });
          }
          if (value == MenuItem.item8) {
            translator
                .translate(myPost['paylasimMetni'], from: 'auto', to: 'hi')
                .then((value) {
              setState(() {
                output2 = value;
              });
            });
          }
          if (value == MenuItem.item9) {
            translator
                .translate(myPost['paylasimMetni'], from: 'auto', to: 'zh-cn')
                .then((value) {
              setState(() {
                output2 = value;
              });
            });
          }
        },
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: MenuItem.item1,
                  child: Row(children: [
                    Text('🇹🇷 '),
                    Text("Turkish",
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(width: 15),
                  ])),
              PopupMenuItem(
                  value: MenuItem.item2,
                  child: Row(children: [
                    Text('🇺🇸 '),
                    Text("English",
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(width: 15),
                  ])),
              PopupMenuItem(
                  value: MenuItem.item3,
                  child: Row(children: [
                    Text('🇸🇦 '),
                    Text("Arabic",
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(width: 15),
                  ])),
              PopupMenuItem(
                  value: MenuItem.item4,
                  child: Row(children: [
                    Text('🇪🇸 '),
                    Text("Spanish",
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(width: 15),
                  ])),
              PopupMenuItem(
                  value: MenuItem.item5,
                  child: Row(children: [
                    Text('🇫🇷 '),
                    Text("French",
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(width: 15),
                  ])),
              PopupMenuItem(
                  value: MenuItem.item6,
                  child: Row(children: [
                    Text('🇩🇪 '),
                    Text("German",
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(width: 15),
                  ])),
              PopupMenuItem(
                  value: MenuItem.item7,
                  child: Row(children: [
                    Text('🇷🇺 '),
                    Text("Russian",
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(width: 15),
                  ])),
              PopupMenuItem(
                  value: MenuItem.item8,
                  child: Row(children: [
                    Text('🇮🇳 '),
                    Text("Indian",
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(width: 15),
                  ])),
              PopupMenuItem(
                  value: MenuItem.item9,
                  child: Row(children: [
                    Text('🇨🇳 '),
                    Text(
                      "Chinese",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(width: 15),
                  ])),
            ]);
  }

  ListView TopMenuItems(BuildContext context) {
    return ListView(
        scrollDirection: Axis.horizontal,
        children: ['home'.tr, 'profile'.tr,'signout'.tr]
            .map((e) => Container(
                margin: ProjectDecorations.symetricPadding,
                child: OutlinedButton(
                  onPressed: () {
                    if (e == 'profile'.tr && auth.currentUser?.email != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    }
                    if(e == 'signout'.tr){
                      //email boş ise yani tokenli kullanıcı ise çıkışa bastığında tokeni silinsin
                      //oturumu kapansın ve login sayfasına yönlendirilsin
                      if(auth.currentUser?.email == null){
                        auth.currentUser?.delete();
                        FirebaseAuth.instance.signOut();
                        PushAndRemovePage(context);

                      }else PushAndRemovePage(context);
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
            .toList());
  }

  Future<dynamic> PushAndRemovePage(BuildContext context) {
    return Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Iskele(),
                        ),
                            (route) => false,
                      );
  }

  void initiateSearch(String val) {
    setState(() {
      name = val.toLowerCase().trim();
      etiket = val.toLowerCase().trim();
    });
  }
}
