import 'dart:ffi';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:barber/presentation/blocs/logout/logout_bloc.dart';
import 'package:barber/presentation/controller/page_controller.dart';
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
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes.dart';
import '../blocs/login/login_bloc.dart';

class HomePageRouter extends StatefulWidget {

  HomePageRouter({super.key});

  @override
  State<HomePageRouter> createState() => _HomePageRouterState();
}

class _HomePageRouterState extends State<HomePageRouter> {
  GetxPageController getxPageController = Get.find();

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
    if (_selectedIndex == 0) {
      getxPageController.currentPage.value = "home";
    } else if (_selectedIndex == 1) {
      getxPageController.currentPage.value = "chat_page";
    } else if (_selectedIndex == 2) {
      getxPageController.currentPage.value = "notification_page";
    } else if (_selectedIndex == 3) {
      getxPageController.currentPage.value = "calendar_page";
    } else if (_selectedIndex == 4) {
      getxPageController.currentPage.value = "profilePage";
    }
    print(_selectedIndex);
    print(getxPageController.currentPage.value);
  }

  @override
  Widget build(BuildContext context) {


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
