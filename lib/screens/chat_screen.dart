import '../config.dart';
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
  final String apiUrl = "$kApiBaseUrl/ai/chat";
  final String summaryUrl = "$kApiBaseUrl/chat/emotion-summary/1";
  final String clearUrl = "$kApiBaseUrl/chat/clear/1";
  final int userId = 1;

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
          _messages.add({"sender": "ai", "text": aiReply ?? "AI無回應"});
        });
      } else {
        _addSystemMessage("伺服器錯誤，請稍後再試。");
      }
    } catch (e) {
      _addSystemMessage("無法連線到伺服器。");
    }
  }

  Future<void> _showEmotionSummary() async {
    try {
      final response = await http.get(Uri.parse(summaryUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('情緒總結'),
              content: Text(
                '總訊息數: ${data['total_messages']}\n'
                '正面: ${(data['positive_ratio'] * 100).toStringAsFixed(1)}%\n'
                '負面: ${(data['negative_ratio'] * 100).toStringAsFixed(1)}%\n'
                '中立: ${(data['neutral_ratio'] * 100).toStringAsFixed(1)}%',
              ),
            );
          },
        );
      } else {
        _addSystemMessage("無法取得情緒總結，請稍後再試。");
      }
    } catch (e) {
      _addSystemMessage("無法連線到伺服器。");
    }
  }

  Future<void> _clearChatLogs() async {
    try {
      final response = await http.delete(Uri.parse(clearUrl));
      if (response.statusCode == 200) {
        setState(() {
          _messages.clear();
        });
        _addSystemMessage("聊天紀錄已清除。");
      } else {
        _addSystemMessage("清除失敗，請稍後再試。");
      }
    } catch (e) {
      _addSystemMessage("無法連線到伺服器。");
    }
  }

  void _addSystemMessage(String text) {
    setState(() {
      _messages.add({"sender": "system", "text": text});
    });
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
                final isSystem = message['sender'] == 'system';
                return Container(
                  alignment:
                      isUser
                          ? Alignment.centerRight
                          : isSystem
                          ? Alignment.center
                          : Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          isUser
                              ? Colors.blue.shade100
                              : isSystem
                              ? Colors.yellow.shade100
                              : Colors.grey.shade300,
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
          Row(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _showEmotionSummary,
                child: Text('情緒總結'),
              ),
              ElevatedButton(onPressed: _clearChatLogs, child: Text('清除紀錄')),
            ],
          ),
        ],
      ),
    );
  }
}
