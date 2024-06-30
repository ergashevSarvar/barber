import 'package:barber/presentation/screens/calendar_page.dart';
import 'package:barber/presentation/screens/chat_page.dart';
import 'package:barber/presentation/screens/home_page.dart';
import 'package:barber/presentation/screens/login_page.dart';
import 'package:barber/presentation/screens/notification_page.dart';
import 'package:barber/presentation/screens/register_page.dart';
import 'package:barber/presentation/screens/user_profile_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String user_profile = '/user_profile';
  static const String calendar_page = '/calendar_page';
  static const String chat_page = '/chat_page';
  static const String notification_page = '/notification_page';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case user_profile:
        return MaterialPageRoute(builder: (_) => UserProfilePage());
      case calendar_page:
        return MaterialPageRoute(builder: (_) => CalendarPage());
      case chat_page:
        return MaterialPageRoute(builder: (_) => ChatPage());
      case notification_page:
        return MaterialPageRoute(builder: (_) => NotificationPage());
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}


