import 'package:barber/presentation/blocs/logout/logout_bloc.dart';
import 'package:barber/presentation/widgets/flashTabBar.dart';
import 'package:barber/presentation/widgets/verticalHorizontalSpace.dart';
import 'package:barber/utils/color.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes.dart';
import '../blocs/login/login_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    Center(child: Text("BOSH SAHIFA")),
    Center(child: Text("CHAT")),
    Center(child: Text("NOTIFICATIONS")),
    Center(child: Text("CALENAR")),
    Center(child: Text("PROFILE"))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: tabItems[_selectedIndex],
      ),
      bottomNavigationBar: Flashtabbar(tabIndex: 0),
    );
  }
}
