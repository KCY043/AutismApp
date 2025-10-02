import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isLoggedIn = false;

  void toggleLogin() {
    setState(() {
      isLoggedIn = !isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('帳號設定')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isLoggedIn ? Icons.check_circle : Icons.logout, size: 80),
            SizedBox(height: 20),
            Text(isLoggedIn ? '已登入' : '尚未登入', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleLogin,
              child: Text(isLoggedIn ? '登出' : '登入'),
            ),
          ],
        ),
      ),
    );
  }
}
