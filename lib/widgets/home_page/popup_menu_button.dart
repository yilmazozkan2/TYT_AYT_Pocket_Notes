import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

enum MenuItem { item1, item2, item3, item4, item5, item6, item7, item8, item9 }

class PopUpMenuButton extends StatefulWidget {
  const PopUpMenuButton({super.key, required this.myPost});
  final DocumentSnapshot<Object?> myPost;

  @override
  State<PopUpMenuButton> createState() => _PopUpMenuButtonState();
}

class _PopUpMenuButtonState extends State<PopUpMenuButton> {

  GoogleTranslator translator = GoogleTranslator();
  var output2;


  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.g_translate,
        color: Theme.of(context).primaryColor,
      ),
      onSelected: (value) {
        if (value == MenuItem.item1) {
          translator
              .translate(widget.myPost['paylasimMetni'], from: 'auto', to: 'tr')
              .then((value) {
            setState(() {
              output2 = value;
            });
          });
        }
        if (value == MenuItem.item2) {
          translator
              .translate(widget.myPost['paylasimMetni'], from: 'auto', to: 'en')
              .then((value) {
            setState(() {
              output2 = value;
            });
          });
        }
        if (value == MenuItem.item3) {
          translator
              .translate(widget.myPost['paylasimMetni'], from: 'auto', to: 'ar')
              .then((value) {
            setState(() {
              output2 = value;
            });
          });
        }
        if (value == MenuItem.item4) {
          translator
              .translate(widget.myPost['paylasimMetni'], from: 'auto', to: 'es')
              .then((value) {
            setState(() {
              output2 = value;
            });
          });
        }
        if (value == MenuItem.item5) {
          translator
              .translate(widget.myPost['paylasimMetni'], from: 'auto', to: 'fr')
              .then((value) {
            setState(() {
              output2 = value;
            });
          });
        }
        if (value == MenuItem.item6) {
          translator
              .translate(widget.myPost['paylasimMetni'], from: 'auto', to: 'de')
              .then((value) {
            setState(() {
              output2 = value;
            });
          });
        }
        if (value == MenuItem.item7) {
          translator
              .translate(widget.myPost['paylasimMetni'], from: 'auto', to: 'ru')
              .then((value) {
            setState(() {
              output2 = value;
            });
          });
        }
        if (value == MenuItem.item8) {
          translator
              .translate(widget.myPost['paylasimMetni'], from: 'auto', to: 'hi')
              .then((value) {
            setState(() {
              output2 = value;
            });
          });
        }
        if (value == MenuItem.item9) {
          translator
              .translate(widget.myPost['paylasimMetni'], from: 'auto', to: 'zh-cn')
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
                  Text("Turkish", style: Theme.of(context).textTheme.bodyText1),
                  const SizedBox(width: 15),
                ])),
            PopupMenuItem(
                value: MenuItem.item2,
                child: Row(children: [
                  Text('🇺🇸 '),
                  Text("English", style: Theme.of(context).textTheme.bodyText1),
                  const SizedBox(width: 15),
                ])),
            PopupMenuItem(
                value: MenuItem.item3,
                child: Row(children: [
                  Text('🇸🇦 '),
                  Text("Arabic", style: Theme.of(context).textTheme.bodyText1),
                  const SizedBox(width: 15),
                ])),
            PopupMenuItem(
                value: MenuItem.item4,
                child: Row(children: [
                  Text('🇪🇸 '),
                  Text("Spanish", style: Theme.of(context).textTheme.bodyText1),
                  const SizedBox(width: 15),
                ])),
            PopupMenuItem(
                value: MenuItem.item5,
                child: Row(children: [
                  Text('🇫🇷 '),
                  Text("French", style: Theme.of(context).textTheme.bodyText1),
                  const SizedBox(width: 15),
                ])),
            PopupMenuItem(
                value: MenuItem.item6,
                child: Row(children: [
                  Text('🇩🇪 '),
                  Text("German", style: Theme.of(context).textTheme.bodyText1),
                  const SizedBox(width: 15),
                ])),
            PopupMenuItem(
                value: MenuItem.item7,
                child: Row(children: [
                  Text('🇷🇺 '),
                  Text("Russian", style: Theme.of(context).textTheme.bodyText1),
                  const SizedBox(width: 15),
                ])),
            PopupMenuItem(
                value: MenuItem.item8,
                child: Row(children: [
                  Text('🇮🇳 '),
                  Text("Indian", style: Theme.of(context).textTheme.bodyText1),
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
}