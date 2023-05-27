import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled1/constants/padding.dart';

//widgets
import '../widgets/home_page/card_posts.dart';
import '../widgets/home_page/search_field.dart';
import '../widgets/home_page/top_menu_items.dart';

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  var output;
  var output2;
  String name = '';
  var tag;

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
          TopMenuItems(),
          SearchField(
            onSearch: (val) => initiateSearch(val),
          ),
          Padding(
            padding: ProjectDecorations.aSymetricPadding,
            child: Text(output2 == null ? "" : output2.toString(),
                style: Theme.of(context).textTheme.bodyText1),
          ),
          Divider(color: Colors.blue, height: 2, thickness: 2),
          CardPosts(name: name, tag: tag),
        ],
      ),
    );
  }

  void initiateSearch(String val) {
    setState(() {
      name = val.toLowerCase().trim();
    });
  }
}
