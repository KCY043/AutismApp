import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'screens/home_screen.dart';
import 'screens/flashcard_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/about_screen.dart';
import 'screens/setting_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 讀取 .env（檔案放專案根目錄；pubspec.yaml 已加入 assets: .env）
  try {
    await dotenv.load(fileName: ".env");
  } catch (_) {
    // 不讓 app 因 .env 不在而崩潰
  }
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
      home: const HomeScreen(), // ← 保留你的原主畫面
      routes: {
        '/home': (context) => const HomeScreen(),
        '/flashcards': (context) => FlashcardScreen(),
        '/chat': (context) => const ChatScreen(),
        '/about': (context) => AboutScreen(),
        '/setting': (context) => SettingScreen(),
      },
    );
  }
}
