import 'package:flutter/material.dart';

class DialogueScreen extends StatelessWidget {
  const DialogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('情境對話')),
      body: const Center(child: Text('情境對話畫面')),
    );
  }
}
