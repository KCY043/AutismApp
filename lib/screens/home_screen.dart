import 'package:flutter/material.dart';
import 'flashcard_screen.dart';
import 'chat_screen.dart';
import 'about_screen.dart';
import 'setting_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _go(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  // 圖片載不到時的占位
  Widget _placeholder({double h = 150, double r = 20}) {
    return Container(
      height: h,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(r),
          topRight: Radius.circular(r),
        ),
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.image_not_supported, color: Colors.grey),
    );
  }

  // 垂直卡片：上圖、下文字＋粉色按鈕
  Widget _verticalFeatureCard({
    required BuildContext context,
    required String title,
    String? subtitle,
    required String assetPath,
    required VoidCallback onStart,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias, // 讓圖片的圓角生效
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 圖片在上
          SizedBox(
            height: 160,
            child: Image.asset(
              assetPath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _placeholder(h: 160),
            ),
          ),
          // 文字 + 按鈕
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ],
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: onStart,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFF472B6),
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    child: const Text('開始練習'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 底部的小按鈕
  Widget _miniNav({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: TextButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: TextButton.styleFrom(
          foregroundColor: Colors.black87,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 頂部不要 AppBar
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Column(
                      children: [
                        // 卡片 1：學習卡 → 學字卡
                        _verticalFeatureCard(
                          context: context,
                          title: '學習卡',
                          subtitle: '加入今日學習與練習',
                          assetPath: 'assets/images/daily.png',
                          onStart: () => _go(context, const FlashcardScreen()),
                        ),
                        const SizedBox(height: 16),
                        // 卡片 2：對話練習 → 聊天
                        _verticalFeatureCard(
                          context: context,
                          title: '對話練習',
                          subtitle: '情境、表達、角色扮演對話',
                          assetPath: 'assets/images/chat.png',
                          onStart: () => _go(context, const ChatScreen()),
                        ),
                      ],
                    ),
                  ),
                ),

                // 底部一排小按鈕
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      _miniNav(
                        context: context,
                        icon: Icons.menu_book_outlined,
                        label: '學習',
                        onTap: () => _go(context, const FlashcardScreen()),
                      ),
                      _miniNav(
                        context: context,
                        icon: Icons.person_outline,
                        label: '帳號',
                        onTap: () => _go(context, SettingScreen()),
                      ),
                      _miniNav(
                        context: context,
                        icon: Icons.info_outline,
                        label: '關於',
                        onTap: () => _go(context, const AboutScreen()),
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
}
