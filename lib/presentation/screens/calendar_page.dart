import 'package:flutter/material.dart';

import '../widgets/flashTabBar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("PAGE"),
      ),
      bottomNavigationBar: Flashtabbar(tabIndex: 3),
    );
  }
}
