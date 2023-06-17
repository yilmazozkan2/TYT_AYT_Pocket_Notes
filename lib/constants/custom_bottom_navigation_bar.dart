import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: navigatorItems,
    );
  }

  List<BottomNavigationBarItem> get navigatorItems {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Ana Sayfa',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.exit_to_app_rounded),
        label: 'Çıkış',
      ),
    ];
  }
}
