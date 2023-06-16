import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/LocaleStrings.dart';
import 'package:untitled1/pages/profile_page.dart';
import 'package:get/get.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  void changeTab(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocalString(),
      locale: Locale('tr', 'TR'),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.black,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.yellow,
            items: items,
            onTap: (value) => changeTab(value)),
        body: pages[_currentIndex],
      ),
    );
  }
}

//kaydolma ekranı başta olmayacak fotoğraf yükleneceği zaman bir sayfa olarak açılsın sadece
final List<Widget> pages = [
  ProfilePage(),
];
final List<BottomNavigationBarItem> items = [
  BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  BottomNavigationBarItem(icon: Icon(Icons.output), label: "Out"),
];
