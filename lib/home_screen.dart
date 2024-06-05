import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sloffee-AI'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).pushNamed('/profile');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: const WebView(
              initialUrl: 'https://sloffee-ai.netlify.app/',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/dashboard');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFE6E6FA), // Lavender purple color
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: Text(
              'Dashboard',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
