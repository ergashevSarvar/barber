import 'package:barber/presentation/components/onboarding_view.dart';
import 'package:barber/presentation/screens/calendar_page.dart';
import 'package:barber/presentation/screens/change_lang_page.dart';
import 'package:barber/presentation/screens/chat_page.dart';
import 'package:barber/presentation/screens/home_page.dart';
import 'package:barber/presentation/screens/home_page_router.dart';
import 'package:barber/presentation/screens/notification_page.dart';
import 'package:barber/presentation/screens/profile_page.dart';
import 'package:barber/presentation/screens/register_page.dart';
import 'package:barber/presentation/screens/register_page2.dart';
import 'package:barber/presentation/screens/signin_page.dart';
import 'package:barber/presentation/screens/signin_types_page.dart';
import 'package:barber/presentation/screens/user_profile_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String register = '/register';
  static const String registerPage = '/registerPage';
  static const String home = '/home';
  static const String user_profile = '/user_profile';
  static const String calendar_page = '/calendar_page';
  static const String chat_page = '/chat_page';
  static const String notification_page = '/notification_page';
  static const String onBoarding = '/onboarding_view';
  static const String signinType = '/signin_type';
  static const String signinPage = '/signin';
  static const String profilePage = '/profilePage';
  static const String changeLangPage = '/changeLangPage';
  static const String homePageRouter = '/homePageRouter';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePageRouter:
        return MaterialPageRoute(builder: (_) => HomePageRouter());
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
      case onBoarding:
        return MaterialPageRoute(builder: (_) => OnboardingView());
      case signinType:
        return MaterialPageRoute(builder: (_) => SigninTypesPage());
      case signinPage:
        return MaterialPageRoute(builder: (_) => SigninPage());
      case signinPage:
        return MaterialPageRoute(builder: (_) => SigninPage());
      case registerPage:
        return MaterialPageRoute(builder: (_) => RegisterPage2());
      case profilePage:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case changeLangPage:
        return MaterialPageRoute(builder: (_) => ChangeLangPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return MaterialPageRoute(builder: (_) => SigninPage());
    }
  }
}


