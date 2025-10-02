# Mac 前端包（Flutter）

## 1) 設定 API Base URL
編輯 `lib/config.dart`，把 `kApiBaseUrl` 改成你的 Windows 主機 IP，例如：
```dart
const String kApiBaseUrl = "http://192.168.0.13:8000";
```

## 2) 安裝 & 執行
```bash
flutter pub get
flutter run
```

## 3) 測試
打開聊天頁面，應該會呼叫：
- POST {kApiBaseUrl}/ai/chat
- GET  {kApiBaseUrl}/chat/emotion-summary/1
- POST {kApiBaseUrl}/chat/clear/1
