import 'package:flutter/material.dart';

import '../pages/login/login_page.dart';
import '../pages/register/register_page.dart';
import '../pages/calendar/calendar_page.dart';
import '../pages/store/store_page.dart';
import '../pages/profile/profile_page.dart';
import '../pages/about/about_page.dart';
import '../pages/tasks/task_list_page.dart';
import '../pages/main_page.dart';


class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String main = '/main';
  static const String calendar = '/calendar';
  static const String tasks = '/tasks';
  static const String store = '/store';
  static const String profile = '/profile';
  static const String about = '/about';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    main: (context) => const MainPage(),
    calendar: (context) => const CalendarPage(),
    tasks: (context) => const TaskListPage(),
    store: (context) => LojaPage(),
    profile: (context) => const ProfilePage(),
    about: (context) => const AboutPage(),
  };
}

