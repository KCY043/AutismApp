import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/flashcard_screen.dart';
import 'screens/dialogue_screen.dart';
import 'screens/game_screen.dart';
import 'screens/about_screen.dart';
import 'screens/setting_screen.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(const AutismApp());
}

class AutismApp extends StatelessWidget {
  const AutismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autism Support App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/flashcards': (context) => FlashcardScreen(),
        '/dialogue': (context) => DialogueScreen(),
        '/game': (context) => GameScreen(),
        '/about': (context) => AboutScreen(),
        '/setting': (context) => SettingScreen(),
        '/chat': (context) => ChatScreen(),
      },
    );
  }
}
