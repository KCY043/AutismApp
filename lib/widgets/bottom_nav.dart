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
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: Colors.white,
      indicatorColor: const Color(0xFFFFECF5), // 粉色選取底
      elevation: 2,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.emoji_emotions), label: '情緒'),
        NavigationDestination(icon: Icon(Icons.videogame_asset), label: '遊戲'),
        NavigationDestination(icon: Icon(Icons.menu_book), label: '學習'),
        NavigationDestination(icon: Icon(Icons.info), label: '關於'),
        NavigationDestination(icon: Icon(Icons.person), label: '我'),
      ],
    );
  }
}
