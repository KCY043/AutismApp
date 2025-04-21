import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('交談紀錄')),
      body: const Center(child: Text('交談紀錄畫面')),
    );
  }
}
