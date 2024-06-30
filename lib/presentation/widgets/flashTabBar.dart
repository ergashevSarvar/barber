import 'package:barber/presentation/blocs/login/login_bloc.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes.dart';
import '../../utils/color.dart';

class Flashtabbar extends StatefulWidget {
  int tabIndex = 0;

  Flashtabbar({super.key, required this.tabIndex});

  @override
  State<Flashtabbar> createState() => _FlashtabbarState();
}

class _FlashtabbarState extends State<Flashtabbar> {
  int _userId = 0;
  String _Token = "";
  void _getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt("userId") ?? 0;
      _Token = prefs.getString("token") ?? "";
    });
  }

  @override
  void initState() {
    _getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlashyTabBar(
      animationCurve: Curves.linear,
      selectedIndex: widget.tabIndex,
      iconSize: 30,
      showElevation: false,
      onItemSelected: (index) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, Routes.home);
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, Routes.chat_page);
        } else if (index == 2) {
          Navigator.pushReplacementNamed(context, Routes.notification_page);
        } else if (index == 3) {
          Navigator.pushReplacementNamed(context, Routes.calendar_page);
        } else if (index == 4) {
          context.read<LoginBloc>().add(GetUserByIdRequest(_userId.toString(), _Token));
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              print(_userId);
             if (state is FetchUserLoading) {
                EasyLoading.show(status: "loading".tr);
              } else if (state is FetchUserSuccess) {
                Navigator.pushReplacementNamed(context, Routes.user_profile);
              }
            },
          );
        }
      },
      items: [
        FlashyTabBarItem(
          icon: Icon(Icons.home_outlined),
          title: Icon(Icons.home_outlined, size: 40, color: kBlue),
        ),
        FlashyTabBarItem(
          icon: Icon(Icons.chat_outlined),
          // title: Text('Chat'),
          title: Icon(Icons.chat_outlined, size: 40, color: kBlue),
        ),
        FlashyTabBarItem(
          icon: Icon(Icons.notifications_none),
          // title: Text('Xabarlar'),
          title: Icon(Icons.notifications_none, size: 40, color: kBlue),
        ),
        FlashyTabBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          // title: Text('Kalendar'),
          title: Icon(Icons.calendar_month_outlined, size: 37, color: kBlue),
        ),
        FlashyTabBarItem(
          icon: Icon(Icons.person_2_outlined),
          // title: Text('Profil'),
          title: Icon(Icons.person_2_outlined, size: 40, color: kBlue),
        ),
      ],
    );
  }
}
