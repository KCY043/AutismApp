import 'package:flutter/material.dart';
import 'flashcard_screen.dart';
import 'game_screen.dart';
import 'chat_screen.dart';
import 'about_screen.dart';
import 'setting_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  Widget _buildCard({
    required BuildContext context,
    required String label,
    required String imagePath,
    required Color borderColor,
    required Widget destination,
  }) {
    return GestureDetector(
      onTap: () => _navigateTo(context, destination),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              color: borderColor.withOpacity(0.1),
              padding: const EdgeInsets.all(16),
              child: Image.asset(imagePath, height: 120),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(label, style: const TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autism App'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue.shade200,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            _buildCard(
              context: context,
              label: '學習卡',
              imagePath: 'assets/images/flashcard.png',
              borderColor: Colors.yellow,
              destination: FlashcardScreen(),
            ),
            _buildCard(
              context: context,
              label: '遊戲',
              imagePath: 'assets/images/game.png',
              borderColor: Colors.red,
              destination: GameScreen(),
            ),
            _buildCard(
              context: context,
              label: '情境對話',
              imagePath: 'assets/images/dialogue.png',
              borderColor: Colors.blue,
              destination: ChatScreen(),
            ),
            _buildCard(
              context: context,
              label: '關於我們',
              imagePath: 'assets/images/about.png',
              borderColor: Colors.grey.shade400,
              destination: AboutScreen(),
            ),
            _buildCard(
              context: context,
              label: '登入 / 登出',
              imagePath: 'assets/images/login.png',
              borderColor: Colors.grey.shade600,
              destination: SettingScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
