// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart'; // 確保這個路徑正確

void main() {
  testWidgets('App loads and shows AppBar title', (WidgetTester tester) async {
    // 建構應用程式並觸發第一幀
    await tester.pumpWidget(const AutismApp());

    // 驗證 AppBar 標題是否存在
    expect(find.text('社交訓練App'), findsOneWidget);

    // 驗證按鈕文字是否存在
    expect(find.text('學習卡'), findsOneWidget);
    expect(find.text('遊戲'), findsOneWidget);
    expect(find.text('情境對話'), findsOneWidget);
    expect(find.text('關於我們'), findsOneWidget);
    expect(find.text('登入/登出'), findsOneWidget);
  });
}
