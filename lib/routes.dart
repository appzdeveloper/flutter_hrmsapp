import 'package:flutter/material.dart';
import 'package:hrms/ui/Error/noInternet.dart';
import 'package:hrms/ui/chat/chat.dart';
import 'package:hrms/ui/profile/myProfile.dart';
import 'package:hrms/ui/register/register.dart';
import 'package:hrms/ui/dashboard/dashboard.dart';

import 'ui/inbox/inbox.dart';
import 'ui/home/home.dart';
import 'ui/login/login.dart';
import 'ui/splash/splash.dart';
import 'ui/onBoarding/onBoardingMain.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String inbox = '/inbox';
  static const String onBoardingMain = '/onBoarding';
  static const String noInternet = '/noInternet';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String chat = '/chat';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    register: (BuildContext context) => RegisterScreen(),
    home: (BuildContext context) => HomeScreen(),
    inbox: (BuildContext context) => InboxScreen(),
    onBoardingMain: (BuildContext context) => OnBoardingMain(),
    noInternet: (BuildContext context) => NoInternetScreen(),
    dashboard: (BuildContext context) => DashboardScreen(),
    profile: (BuildContext context) => ProfileScreen(),
    chat: (BuildContext context) => ChatScreen(),
  };
}
