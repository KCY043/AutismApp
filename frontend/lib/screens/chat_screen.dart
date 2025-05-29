import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final String apiUrl = "http://localhost:8000/ai/chat"; // 確認是後端正確網址
  final int userId = 1; // 假設測試用 ID

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add({"sender": "user", "text": text});
    });
    _controller.clear();

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"content": text, "user_id": userId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final aiReply = data["response"];
        setState(() {
          _messages.add({"sender": "ai", "text": aiReply});
        });
      } else {
        setState(() {
          _messages.add({"sender": "ai", "text": "伺服器錯誤，請稍後再試。"});
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({"sender": "ai", "text": "無法連線到伺服器。"});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('對話互動')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';
                return Container(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          isUser ? Colors.blue.shade100 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Text(message['text'] ?? ''),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "輸入訊息...",
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
