import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/padding.dart';

class LanguageIconButton extends StatelessWidget {
  LanguageIconButton({super.key});

  final List locale = [
    {'name': 'TURKISH', 'locale': Locale('tr')},
    {'name': 'ENGLISH', 'locale': Locale('en')},
    {'name': 'ARABIC', 'locale': Locale('ar')},
    {'name': 'SPANISH', 'locale': Locale('es')},
    {'name': 'FRENCH', 'locale': Locale('fr')},
    {'name': 'GERMAN', 'locale': Locale('de')},
    {'name': 'RUSSIAN', 'locale': Locale('ru')},
    {'name': 'INDIAN', 'locale': Locale('hi')},
    {'name': 'CHINESE', 'locale': Locale('zh-cn')},
  ];
  
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          builddialog(context);
        },
        icon: Icon(Icons.language),
        color: Colors.blue);
  }

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  AlertDialog alertDialog() {
    return AlertDialog(
      title: Text('Choose App Language'),
      content: Container(
        width: double.maxFinite,
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: ProjectDecorations.allPadding,
                child: GestureDetector(
                    onTap: () {
                      print((locale[index]['name']));
                      updateLanguage(locale[index]['locale']);
                    },
                    child: Text(
                      locale[index]['name'],
                    )),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.blue,
              );
            },
            itemCount: locale.length),
      ),
    );
  }

  builddialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return alertDialog();
        });
  }
}
