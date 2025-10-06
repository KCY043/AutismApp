import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  /// 讀 .env；沒設定就走本機
  static String get _rawBase =>
      dotenv.env['BACKEND_URL'] ?? 'http://127.0.0.1:8000/';

  /// 去掉尾巴的 /，避免 //chat
  static String get baseUrl {
    final b = _rawBase.trim();
    return b.endsWith('/') ? b.substring(0, b.length - 1) : b;
  }

  /// 健康檢查
  static Future<void> ping() async {
    try {
      final r = await http
          .get(Uri.parse('$baseUrl/healthz'))
          .timeout(const Duration(seconds: 3));
      // ignore: avoid_print
      print('✅ Backend OK: ${r.statusCode} ${r.body}');
    } catch (e) {
      // ignore: avoid_print
      print('⚠️ Backend unreachable: $e');
    }
  }

  /// 聊天
  static Future<Map<String, dynamic>> sendMessage({
    required String text,
    required int userId,
  }) async {
    final uri = Uri.parse('$baseUrl/chat');
    final body = jsonEncode({
      'content_b64': base64Encode(utf8.encode(text)), // 避免亂碼
      'user_id': userId,
    });

    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: body,
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
    }
    throw Exception('HTTP ${res.statusCode}: ${res.body}');
  }

  /// 情緒總結
  static Future<Map<String, dynamic>> getEmotionSummary(int userId) async {
    final uri = Uri.parse('$baseUrl/chat/emotion-summary/$userId');
    final res = await http.get(uri);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
    }
    throw Exception('Emotion summary error: ${res.statusCode}');
  }

  /// 清空對話
  static Future<void> clearChat(int userId) async {
    final uri = Uri.parse('$baseUrl/chat/clear/$userId');
    final res = await http.delete(uri);
    if (res.statusCode != 200) {
      throw Exception('Clear chat failed: ${res.statusCode}');
    }
  }
}
