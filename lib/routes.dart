import 'package:barber/presentation/screens/home_page.dart';
import 'package:barber/presentation/screens/login_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String login = '/login';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}


