import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.indigo,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.emoji_emotions), label: '情緒'),
        BottomNavigationBarItem(icon: Icon(Icons.videogame_asset), label: '遊戲'),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: '學習'),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: '關於'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '我'),
      ],
    );
  }
}
