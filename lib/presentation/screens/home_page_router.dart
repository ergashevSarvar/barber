import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:barber/presentation/blocs/logout/logout_bloc.dart';
import 'package:barber/presentation/screens/calendar_page.dart';
import 'package:barber/presentation/screens/chat_page.dart';
import 'package:barber/presentation/screens/home_page.dart';
import 'package:barber/presentation/screens/notification_page.dart';
import 'package:barber/presentation/screens/profile_page.dart';
import 'package:barber/presentation/screens/user_profile_page.dart';
import 'package:barber/presentation/widgets/verticalHorizontalSpace.dart';
import 'package:barber/utils/color.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes.dart';
import '../blocs/login/login_bloc.dart';

class HomePageRouter extends StatefulWidget {
  final int index;

  HomePageRouter({super.key, required this.index});

  @override
  State<HomePageRouter> createState() => _HomePageRouterState();
}

class _HomePageRouterState extends State<HomePageRouter> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ChatPage(),
    NotificationPage(),
    CalendarPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index == 99) {
      _selectedIndex = _selectedIndex;
    } else if (widget.index == 5) {
      _selectedIndex = 4;
    }
    // _selectedIndex = widget.index == 99 ? _selectedIndex : widget.index;
    print(_selectedIndex);
    return Scaffold(
      backgroundColor: kWhite,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(5, 5),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: -2,
              offset: Offset(-5, -5),
            ),
          ],
        ),
        child: BottomBarCreative(
          indexSelected: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            TabItem(icon: Icons.home_outlined, title: 'Bosh sahifa'),
            TabItem(icon: Icons.map_outlined, title: 'Xarita'),
            TabItem(icon: Icons.cut, title: ''),
            TabItem(icon: Icons.message_outlined, title: 'Xabarlar'),
            TabItem(icon: Icons.person, title: 'Kabinet'),
          ],
          backgroundColor: Colors.white,
          color: Colors.grey,
          iconSize: 24,
          colorSelected: textYellow,
        ),
      ),
    );
  }
}
