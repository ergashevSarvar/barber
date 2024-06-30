import 'package:flutter/material.dart';

import '../widgets/flashTabBar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("PAGE"),
      ),
      bottomNavigationBar: Flashtabbar(tabIndex: 2),
    );
  }
}
