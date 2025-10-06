import 'package:flutter/material.dart';

class FlashcardScreen extends StatelessWidget {
  const FlashcardScreen({super.key});

  static final _items = <Map<String, String>>[
    {'label': '蘋果', 'img': 'assets/images/apple.png'},
    {'label': '床', 'img': 'assets/images/bed.png'},
    {'label': '生氣', 'img': 'assets/images/angry.png'},
    {'label': '鳥', 'img': 'assets/images/bird.png'},
  ];

  @override
  Widget build(BuildContext context) {
    const double imgSize = 104; // ← 放大
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('學字卡'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: _items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.95, // ← 比例調小，讓卡片更高可容納更大圖
          ),
          itemBuilder: (_, i) {
            final it = _items[i];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      it['img']!,
                      width: imgSize,
                      height: imgSize,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) => Container(
                            width: imgSize,
                            height: imgSize,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(it['label']!, style: const TextStyle(fontSize: 14)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
