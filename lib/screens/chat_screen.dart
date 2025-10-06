import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<_Msg> _messages = [];
  bool _sending = false;
  final int _userId = 1;

  @override
  void initState() {
    super.initState();
    Api.ping();
  }

  @override
  void dispose() {
    _showEmotionSummary(auto: true);
    _controller.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    await _showEmotionSummary(auto: true);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFFF8FAFC);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          title: const Text('情境對話'),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              tooltip: '情緒總結',
              icon: const Icon(Icons.analytics_outlined),
              onPressed: () => _showEmotionSummary(),
            ),
            IconButton(
              tooltip: '清空對話',
              icon: const Icon(Icons.delete_outline),
              onPressed: _confirmClear,
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: Column(
              children: [
                // 頂端：參與者小頭像列 + 小標
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: const [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0xFFA7F3D0),
                      ),
                      SizedBox(width: 6),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0xFFFDE68A),
                      ),
                      SizedBox(width: 6),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0xFFBFDBFE),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '對話練習',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // 中段：訊息卡片（柔色漸層背景 + 陰影）
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFFFF1F7), Color(0xFFF0F9FF)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                    child: ListView.builder(
                      itemCount: _messages.length,
                      reverse: false,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final m = _messages[index];
                        final isUser = m.role == _Role.user;

                        final bubbleBg =
                            isUser ? const Color(0xFFF472B6) : Colors.white;
                        final textColor =
                            isUser ? Colors.white : Colors.black87;
                        final radius = BorderRadius.only(
                          topLeft: const Radius.circular(18),
                          topRight: const Radius.circular(18),
                          bottomLeft:
                              isUser
                                  ? const Radius.circular(18)
                                  : const Radius.circular(6),
                          bottomRight:
                              isUser
                                  ? const Radius.circular(6)
                                  : const Radius.circular(18),
                        );

                        return Align(
                          alignment:
                              isUser
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: bubbleBg,
                              borderRadius: radius,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  isUser
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  m.text,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  DateFormat('HH:mm').format(m.ts),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        isUser
                                            ? Colors.white.withOpacity(0.9)
                                            : Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // 底部：圓角輸入盒 + 送出鈕 + 查看情緒總結
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              textInputAction: TextInputAction.send,
                              onSubmitted: (_) => _onSend(),
                              decoration: InputDecoration(
                                hintText: '輸入訊息…',
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 12,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF3F4F6),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          FilledButton.tonal(
                            onPressed: _sending ? null : _onSend,
                            style: FilledButton.styleFrom(
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              minimumSize: const Size(48, 44),
                            ),
                            child:
                                _sending
                                    ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : const Icon(Icons.send),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _showEmotionSummary,
                          icon: const Icon(Icons.analytics),
                          label: const Text('查看情緒總結'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(44),
                            shape: const StadiumBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onSend() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_Msg(_Role.user, text));
      _sending = true;
    });
    _controller.clear();

    try {
      final resp = await Api.sendMessage(text: text, userId: _userId);
      final ai = (resp['ai_reply'] as String?) ?? '（AI 無回應）';
      setState(() {
        _messages.add(_Msg(_Role.assistant, ai));
      });
    } catch (e) {
      setState(() {
        _messages.add(_Msg(_Role.assistant, '⚠️ 無法連線：$e'));
      });
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _showEmotionSummary({bool auto = false}) async {
    try {
      final summary = await Api.getEmotionSummary(_userId);
      if (!mounted) return;

      final text = (summary['summary'] as String?)?.trim();
      if (auto && (text == null || text.isEmpty)) return;

      await showDialog<void>(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('💬 情緒總結'),
              content: SingleChildScrollView(child: Text(text ?? '暫無分析結果')),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('確定'),
                ),
              ],
            ),
      );
    } catch (e) {
      if (!auto && mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('無法取得情緒總結：$e')));
      }
    }
  }

  Future<void> _confirmClear() async {
    final ok = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('清空對話'),
            content: const Text('要清空本次對話紀錄嗎？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('取消'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('清空'),
              ),
            ],
          ),
    );
    if (ok == true) {
      try {
        await Api.clearChat(_userId);
        if (!mounted) return;
        setState(() => _messages.clear());
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('已清空對話')));
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('清空失敗：$e')));
      }
    }
  }
}

enum _Role { user, assistant }

class _Msg {
  final _Role role;
  final String text;
  final DateTime ts;
  _Msg(this.role, this.text) : ts = DateTime.now();
}
