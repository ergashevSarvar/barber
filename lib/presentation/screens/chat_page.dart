import 'package:flutter/material.dart';

import '../widgets/flashTabBar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("PAGE"),
      ),
      bottomNavigationBar: Flashtabbar(tabIndex: 1),
    );
  }
}
